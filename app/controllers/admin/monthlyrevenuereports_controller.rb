#encoding: utf-8
class Admin::MonthlyrevenuereportsController < AdminController
  before_action :set_monthlyrevenuereport, only: [:show, :edit, :editbymonth, :update, :destroy, :edithistoryrevenue]

  # GET /monthlyrevenuereports
  # GET /monthlyrevenuereports.json
  def index
    @monthlyrevenuereports = Monthlyrevenuereport.all
    @NewMonthly = Monthlyrevenuereport.new
  end

  # GET /monthlyrevenuereports/1
  # GET /monthlyrevenuereports/1.json
  def show
 
  	if !params[:fiscal_month].nil?
  		@currentMonth = params[:fiscal_month]
  		@revenue_items = @monthlyrevenuereport.revenue_items.where('fiscal_month='+@currentMonth.to_s)
  	else
  		#find latest month in this year
  		if @monthlyrevenuereport.revenue_items.count > 0
  			redirect_to  admin_monthlyrevenuereport_path(@monthlyrevenuereport, fiscal_month: @monthlyrevenuereport.revenue_items.order('fiscal_month').last.fiscal_month)
  		end
  	end
  	#latest 8 years
  	#@historyRevenues = Attachment.where('attachable_type="Monthlyrevenuereport"').order('attachable_id').limit(8)

  	#latest 8 year from current selection (on fiscal_year)
  	@history_array =  Monthlyrevenuereport.where("fiscal_year < ? ",@monthlyrevenuereport.fiscal_year).order('fiscal_year desc').select(:id).limit(8).map {|i| i.id }
  	@historyRevenues = Attachment.where(attachable_id: @history_array, attachable_type: "Monthlyrevenuereport").index_by(&:attachable_id).slice(*@history_array).values
  	
  	p @historyRevenues
  	

  end

  # GET /monthlyrevenuereports/new
  def new
    @monthlyrevenuereport = Monthlyrevenuereport.new
  end

  # GET /monthlyrevenuereports/1/edit
  def edit
  	#@monthlyRRpt = Monthlyrevenuereport.find(params[:id]) if !params[:id].nil?
  	#要加入 參數檢查 month 1...12 
  	if !params[:fiscal_month].nil?
  		@currentMonth = params[:fiscal_month]
  		@revenue_items = @monthlyrevenuereport.revenue_items.where('fiscal_month='+@currentMonth.to_s)
  	end
  	
	@newRevenueitem = RevenueItem.new
  end
  
  def editbymonth
  	if !params[:fiscal_month].nil?
  		@currentMonth = params[:fiscal_month]
  		@revenue_items = @monthlyrevenuereport.revenue_items.where('fiscal_month='+@currentMonth.to_s)
  	end
  	
	@newRevenueitem = RevenueItem.new
  end

  # POST /monthlyrevenuereports
  # POST /monthlyrevenuereports.json
  def create
    @monthlyrevenuereport = Monthlyrevenuereport.new(monthlyrevenuereport_params)

    respond_to do |format|
      if @monthlyrevenuereport.save
        format.html { redirect_to  editbymonth_admin_monthlyrevenuereport_path(@monthlyrevenuereport,fiscal_month: DateTime.now.month), notice: 'Monthlyrevenuereport was successfully created.' }
        format.json { render action: 'show', status: :created, location: admin_monthlyrevenuereport_path(@monthlyrevenuereport) }
      else
        format.html { render action: 'new' }
        format.json { render json: @monthlyrevenuereport.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /monthlyrevenuereports/1
  # PATCH/PUT /monthlyrevenuereports/1.json
  def update
  	
    respond_to do |format|
      if @monthlyrevenuereport.update(monthlyrevenuereport_params)
      	
      	if params[:filename].present? 
 			display_name = params[:filename] 
 		else 
 			display_name = "#{@monthlyrevenuereport.fiscal_year}年-營業收入"
 		end
 		Attachment.create(:attachment => params[:attachment], :attachable => @monthlyrevenuereport, :file_name => display_name) if params[:attachment]	
 		
        format.html { redirect_to editbymonth_admin_monthlyrevenuereport_path(@monthlyrevenuereport, fiscal_month: params[:fiscal_month]), notice: 'Monthlyrevenuereport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @monthlyrevenuereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monthlyrevenuereports/1
  # DELETE /monthlyrevenuereports/1.json
  def destroy
    @monthlyrevenuereport.destroy
    respond_to do |format|
      format.html { redirect_to admin_monthlyrevenuereports_path }
      format.json { head :no_content }
    end
  end
  
  #not in use
  def edithistoryrevenue
  	@monthlyrevenuereports = Monthlyrevenuereport.all
  	@historyRevenues = Attachment.where('attachable_type="Monthlyrevenuereport"').order('attachable_id')
	end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthlyrevenuereport
      @monthlyrevenuereport = Monthlyrevenuereport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monthlyrevenuereport_params
      params.require(:monthlyrevenuereport).permit(:fiscal_year)
    end
end
