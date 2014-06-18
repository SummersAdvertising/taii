#encoding: utf-8
class Admin::HistoryrevenuereportsController < AdminController
  before_action :set_historyrevenuereport, only: [:show, :edit, :update, :destroy]

  # GET /historyrevenuereports
  # GET /historyrevenuereports.json
  def index
    @historyrevenuereports = Historyrevenuereport.all
    @NewHistory = Historyrevenuereport.new
  end

  # GET /historyrevenuereports/1
  # GET /historyrevenuereports/1.json
  def show
  end

  # GET /historyrevenuereports/new
  def new
    @historyrevenuereport = Historyrevenuereport.new
  end

  # GET /historyrevenuereports/1/edit
  def edit
  end

  # POST /historyrevenuereports
  # POST /historyrevenuereports.json
  def create
    @historyrevenuereport = Historyrevenuereport.new(historyrevenuereport_params)

    respond_to do |format|
      if @historyrevenuereport.save
        format.html { redirect_to edit_admin_historyrevenuereport_path(@historyrevenuereport), notice: 'Historyrevenuereport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @historyrevenuereport }
      else
        format.html { render action: 'new' }
        format.json { render json: @historyrevenuereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historyrevenuereports/1
  # PATCH/PUT /historyrevenuereports/1.json
  def update
    respond_to do |format|
      if @historyrevenuereport.update(historyrevenuereport_params)
      
        if params[:filename].present? 
 			display_name = params[:filename] 
 		else 
 			display_name = "#{@historyrevenuereport.fiscal_year}年-財務報告-#{@historyrevenuereport.attachments.count + 1}"
 		end
 		Attachment.create(:attachment => params[:attachment], :attachable => @historyrevenuereport, :file_name => display_name) if params[:attachment]	
     		
        format.html { redirect_to edit_admin_historyrevenuereport_path(@historyrevenuereport), notice: 'Historyrevenuereport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @historyrevenuereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historyrevenuereports/1
  # DELETE /historyrevenuereports/1.json
  def destroy
    @historyrevenuereport.destroy
    respond_to do |format|
      format.html { redirect_to admin_historyrevenuereports_path }
      format.json { head :no_content }
    end
  end

  #multiReorder
  def multiple_reorder
  	errorFlag = false
  	params[:historyrevenuereport][:reorderset].each_with_index do | attachid , index | 
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
    def set_historyrevenuereport
      @historyrevenuereport = Historyrevenuereport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historyrevenuereport_params
      params.require(:historyrevenuereport).permit(:fiscal_year)
    end
  
end
