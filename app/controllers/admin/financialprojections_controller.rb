#encoding: utf-8
class Admin::FinancialprojectionsController < AdminController
  before_action :set_financialprojection, only: [:show, :edit, :update, :destroy, :create_attachment]

  # GET /financialprojections/1/edit
  def edit
  	
  end

  # PATCH/PUT /financialprojections/1
  # PATCH/PUT /financialprojections/1.json
  def update
    respond_to do |format|
      if @financialprojection.update(financialprojection_params) && ( params[ :article ].nil? ^ @financialprojection.article.update( params.require(:article).permit(:content) ) )
        format.html { redirect_to edit_admin_financialprojection_path(id: 1), notice: 'Financialprojection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @financialprojection.errors, status: :unprocessable_entity }
      end
    end
  end
  
   def create_attachment
  		#deal with attachment
 		if params[:filename].present? 
 			display_name = params[:filename] 
 		else 
 			display_name = "#{@financialprojection.title}-附件-#{@financialprojection.attachments.count + 1}"
 		end
 		@latestAttach = Attachment.create(:attachment => params[:attachment], :attachable => @financialprojection, :file_name => display_name) if params[:attachment]
 		
 		respond_to do |format|
 				format.js
		  	 	format.json { head :no_content }
		  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financialprojection
      @financialprojection = Financialprojection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def financialprojection_params
      params.require(:financialprojection).permit(:title, :article_id)
    end
end
