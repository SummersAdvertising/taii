class BrproductsController < ApplicationController
  before_action :set_brproduct, only: [:show, :fetch]

  # GET /brproducts
  # GET /brproducts.json
  def index
    @brproducts = Brproduct.all
  end

  # GET /brproducts/1
  # GET /brproducts/1.json
  def show
  end
  
  def fetch
  
 		 @breadcrumb = (Brlevel.find(@brproduct.brlevel_id)).find_my_direct_parent
  	 @contact_org = Organization.find(@brproduct.organization_id) 
		 @sales = Representative.where(['organization_id = ?', @contact_org.id]) 
		 @attachments = @brproduct.attachments

	   respond_to do |format|
         format.js
     end
     
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brproduct
      @brproduct = Brproduct.find(params[:id])
    end

end
