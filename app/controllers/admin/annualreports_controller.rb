#encoding: utf-8
class Admin::AnnualreportsController < AdminController
  before_action :set_annualreport, only: [:show, :edit, :update, :destroy]

  # GET /annualreports
  # GET /annualreports.json
  def index
    @annualreports = Annualreport.all
    @newannualreport = Annualreport.new
  end

  # GET /annualreports/1
  # GET /annualreports/1.json
  def show
  end

  # GET /annualreports/new
  def new
    @annualreport = Annualreport.new
  end

  # GET /annualreports/1/edit
  def edit
  end

  # POST /annualreports
  # POST /annualreports.json
  def create
    @annualreport = Annualreport.new(annualreport_params)

    respond_to do |format|
      if @annualreport.save
        format.html { redirect_to edit_admin_annualreport_path(@annualreport), notice: 'Annualreport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @annualreport }
      else
        format.html { render action: 'new' }
        format.json { render json: @annualreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annualreports/1
  # PATCH/PUT /annualreports/1.json
  def update
    respond_to do |format|
      if @annualreport.update(annualreport_params)
      
        if params[:filename].present? 
 			display_name = params[:filename] 
 		else 
 			display_name = "#{@annualreport.fiscal_year}年-財務報告-#{@annualreport.attachments.count + 1}"
 		end
 		Attachment.create(:attachment => params[:attachment], :attachable => @annualreport, :file_name => display_name) if params[:attachment]	
     		
        format.html { redirect_to edit_admin_annualreport_path(@annualreport), notice: 'Annualreport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @annualreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annualreports/1
  # DELETE /annualreports/1.json
  def destroy
    @annualreport.destroy
    respond_to do |format|
      format.html { redirect_to admin_annualreports_path }
      format.json { head :no_content }
    end
  end

  #multiReorder
  def multiple_reorder
  	errorFlag = false
  	params[:annualreport][:reorderset].each_with_index do | attachid , index | 
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
    def set_annualreport
      @annualreport = Annualreport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def annualreport_params
      params.require(:annualreport).permit(:fiscal_year)
    end
  
end
