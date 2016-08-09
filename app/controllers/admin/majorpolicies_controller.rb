#encoding: utf-8
class Admin::MajorpoliciesController < AdminController
  before_action :set_majorpolicy, only: [:show, :edit, :update, :destroy, :create_attachment]

  # GET /majorpolicys/1/edit
  def edit
  	
  end

  # PATCH/PUT /majorpolicys/1
  # PATCH/PUT /majorpolicys/1.json
  def update
    respond_to do |format|
      if @majorpolicy.update(majorpolicy_params) && ( params[ :article ].nil? ^ @majorpolicy.article.update( params.require(:article).permit(:content) ) )
        format.html { redirect_to edit_admin_majorpolicy_path(id: 1), notice: 'Majorpolicy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @majorpolicy.errors, status: :unprocessable_entity }
      end
    end
  end
  
   def create_attachment
  		#deal with attachment
 		if params[:filename].present? 
 			display_name = params[:filename] 
 		else 
 			display_name = "公司治理-附件-#{@majorpolicy.attachments.count + 1}"
 		end
 		@latestAttach = Attachment.create(:attachment => params[:attachment], :attachable => @majorpolicy, :file_name => display_name) if params[:attachment]
 		
 		respond_to do |format|
 				format.js
		  	 	format.json { head :no_content }
		  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_majorpolicy
      @majorpolicy = Majorpolicy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def majorpolicy_params
      params.require(:majorpolicy).permit(:title, :article_id)
    end
end
