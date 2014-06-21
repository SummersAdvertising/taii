#encoding: utf-8
class Admin::FinancialreportsController < AdminController
  before_action :set_financialreport, only: [:show, :edit, :update, :destroy]

  # GET /financialreports
  # GET /financialreports.json
  def index
    @financialreports = Financialreport.all
    @Newfinancial = Financialreport.new
  end

  # GET /financialreports/1
  # GET /financialreports/1.json
  def show
  end

  # GET /financialreports/new
  def new
    @financialreport = Financialreport.new
  end

  # GET /financialreports/1/edit
  def edit
  end

  # POST /financialreports
  # POST /financialreports.json
  def create
    @financialreport = Financialreport.new(financialreport_params)

    respond_to do |format|
      if @financialreport.save
        format.html { redirect_to edit_admin_financialreport_path(@financialreport), notice: 'Financialreport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @financialreport }
      else
        format.html { redirect_to admin_financialreports_path, notice: @financialreport.errors.full_messages }
        format.json { render json: @financialreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /financialreports/1
  # PATCH/PUT /financialreports/1.json
  def update
    respond_to do |format|
      if @financialreport.update(financialreport_params)
      
        if params[:filename].present? 
 			display_name = params[:filename] 
 		else 
 			display_name = "#{@financialreport.fiscal_year}年-財務報告-#{@financialreport.attachments.count + 1}"
 		end
 		Attachment.create(:attachment => params[:attachment], :attachable => @financialreport, :file_name => display_name) if params[:attachment]	
     		
        format.html { redirect_to edit_admin_financialreport_path(@financialreport), notice: 'Financialreport was successfully updated.' }
        format.json { head :no_content }
      else
        format.json { render json: @financialreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /financialreports/1
  # DELETE /financialreports/1.json
  def destroy
    @financialreport.destroy
    respond_to do |format|
      format.html { redirect_to admin_financialreports_path }
      format.json { head :no_content }
    end
  end

  #multiReorder
  def multiple_reorder
  	errorFlag = false
  	params[:financialreport][:reorderset].each_with_index do | attachid , index | 
  		@fAttach = Attachment.find(attachid)
  		if !@fAttach.nil?
  			@fAttach.update_attribute(:ranking , index+1 )
  		else
  			errorFlag = true
  		end	
  	end
  	
  	respond_to do |format|
	  	 if errorFlag
	  	 	format.json { head :no_content }
	  	 else
	  	 	format.json { head :no_content }
	  	 end
	  end
	  
  end
	  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financialreport
      @financialreport = Financialreport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def financialreport_params
      params.require(:financialreport).permit(:fiscal_year)
    end
  
end
