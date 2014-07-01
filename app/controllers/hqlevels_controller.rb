class HqlevelsController < ApplicationController
  before_action :set_hqlevel, only: [:show, :edit, :update, :destroy,:fetch]
	
  # GET /hqlevels
  # GET /hqlevels.json
  def index
    @hqlevels = Hqlevel.all
  end
  
  # GET /hqlevels/1
  # GET /hqlevels/1.json
  def show
  	
		I18n.locale = params[:locale]

  	@current_root = Hqlevel.return_root_node_on_demand(I18n.locale)
  	@level_relations = Hqlevel.get_level_hierarchy()
  	@product_relations = Hqlevel.get_all_level_product_pairs()

  	if( params[:product] )
  	  @default_product = Hqproduct.find(params[:product])  		
  	else	
  		@default_product = Hqproduct.find(@product_relations.first[2])
  	end  	
  	
  	@contact_org = Organization.find(@default_product.organization_id) 
		@sales = Representative.where(['organization_id = ?', @contact_org.id]) 
		@attachments = @default_product.attachments
		
  end
  
  # GET /hqlevels/new
  def new
    @hqlevel = Hqlevel.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hqlevel
      @hqlevel = Hqlevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hqlevel_params
      params.require(:hqlevel).permit(:name, :level, :parent)
    end
end
