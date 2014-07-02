class HqproductsController < ApplicationController
  before_action :set_hqproduct, only: [:show, :fetch]

  # GET /hqproducts
  # GET /hqproducts.json
  def index
    @hqproducts = Hqproduct.all
  end

  # GET /hqproducts/1
  # GET /hqproducts/1.json
  def show

  end

  def fetch
  
		 @breadcrumb = (Hqlevel.find(@hqproduct.hqlevel_id)).find_my_direct_parent
		 
		 if @hqproduct.organization_id != 0
			 @contact_org = Organization.find(@hqproduct.organization_id) 
	 		 @sales = Representative.where(['organization_id = ?', @contact_org.id]) 
		 end

		 @attachments = @hqproduct.attachments
		 
	   respond_to do |format|
         format.js
     end
     
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hqproduct
      @hqproduct = Hqproduct.find(params[:id])
    end
end
