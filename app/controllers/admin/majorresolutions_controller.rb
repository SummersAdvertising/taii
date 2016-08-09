#encoding: utf-8
class Admin::MajorresolutionsController < AdminController
  before_action :set_majorresolution, only: [:show, :edit, :update, :destroy]

  # GET /majorresolutions
  # GET /majorresolutions.json
  def index
    @majorresolutions = Majorresolution.all
    @newMajor = Majorresolution.new
  end

  # GET /majorresolutions/1
  # GET /majorresolutions/1.json
  def show
  end

  # GET /majorresolutions/new
  def new
    @majorresolution = Majorresolution.new
  end

  # GET /majorresolutions/1/edit
  def edit
  end

  # POST /majorresolutions
  # POST /majorresolutions.json
  def create
    @majorresolution = Majorresolution.new(majorresolution_params)

    respond_to do |format|
      if @majorresolution.save
        format.html { redirect_to edit_admin_majorresolution_path(@majorresolution), notice: 'Majorresolution was successfully created.' }
        format.json { render action: 'show', status: :created, location: @majorresolution }
      else
        format.html { redirect_to admin_majorresolutions_path, notice: @majorresolution.errors.full_messages }
        format.json { render json: @majorresolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /majorresolutions/1
  # PATCH/PUT /majorresolutions/1.json
  def update
    respond_to do |format|
      if @majorresolution.update(majorresolution_params)
      
        if params[:filename].present? 
 			display_name = params[:filename] 
 		else 
 			display_name = "#{@majorresolution.fiscal_year}年-重要決議-#{@majorresolution.attachments.count + 1}"
 		end
 		Attachment.create(:attachment => params[:attachment], :attachable => @majorresolution, :file_name => display_name) if params[:attachment]	
     		
        format.html { redirect_to edit_admin_majorresolution_path(@majorresolution), notice: 'Majorresolution was successfully updated.' }
        format.json { head :no_content }
      else
        format.json { render json: @majorresolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /majorresolutions/1
  # DELETE /majorresolutions/1.json
  def destroy
    @majorresolution.destroy
    respond_to do |format|
      format.html { redirect_to admin_majorresolutions_path }
      format.json { head :no_content }
    end
  end

  #multiReorder
  def multiple_reorder
  	errorFlag = false
  	params[:majorresolution][:reorderset].each_with_index do | attachid , index | 
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
    def set_majorresolution
      @majorresolution = Majorresolution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def majorresolution_params
      params.require(:majorresolution).permit(:fiscal_year)
    end
  
end
