class Admin::AttachmentsController < AdminController
  
  #multiReorder
  def multiple_reorder
  	errorFlag = false
  	params[:attachment][:reorderset].each_with_index do | attachmentid , index | 
  		@fAttachment = Attachment.find(attachmentid)
  		if !@fAttachment.nil?
  			@fAttachment.update_attribute(:ranking , index+1 )
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
  
	def destroy
		@attachment = Attachment.find(params[:id])

        # public/uploads/attachment/#{model.attachable_type}/#{model.attachable_id}/attachment/#{model.id}
		#-- delete file only (remain lots of empty folder)
		#@attachmentpath = "public/uploads/attachment/" + @attachment.attachable_type.to_s + "/" + @attachment.attachable_id.to_s + "/attachment/" + @attachment.id.to_s + "/" + @attachment.file_name
		#File.delete(@attachmentpath)
		#-- delete file only end
		#delete entire folder 
		@attachmentpath = "public/uploads/attachment/" + @attachment.attachable_type.to_s + "/" + @attachment.attachable_id.to_s + "/attachment/" + @attachment.id.to_s
		FileUtils.rm_rf(@attachmentpath)
		@attachment.destroy

		if @attachment.attachable_type.underscore != 'monthlyrevenuereport'		
					respond_to do |format|
	          format.html { redirect_to :controller => @attachment.attachable_type.underscore.pluralize , :action => "edit", :id => @attachment.attachable_id, locale: I18n.locale }
	          end
    else
					respond_to do |format|
    	      	format.html { redirect_to :controller => @attachment.attachable_type.underscore.pluralize , :action => "editbymonth", :id => @attachment.attachable_id, fiscal_month: params[:fiscal_month]}
    	      	format.json { head :no_content }
				  end
    end
      
	end

end