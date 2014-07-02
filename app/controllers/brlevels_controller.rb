class BrlevelsController < ApplicationController
  before_action :set_brlevel, only: [:show]

  # GET /brlevels
  # GET /brlevels.json
  def index
    @brlevels = Brlevel.all
  end

  # GET /brlevels/1
  # GET /brlevels/1.json
  def show
  	
  	I18n.locale = params[:locale]
		
		@current_root = Brlevel.return_root_node_on_demand(I18n.locale)
  	@level_relations = Brlevel.get_level_hierarchy()
  	@product_relations = Brlevel.get_all_level_product_pairs()

  	if( params[:product] )
  	  @default_product = Brproduct.find(params[:product])  		
  	else	
  		if @product_relations.count > 0
	  		@default_product = Brproduct.find(@product_relations.first[2]) #要修改
	  	end
  	end  	
  	
  	if !@default_product.nil?
	  	@contact_org = Organization.find(@default_product.organization_id) 
			@sales = Representative.where(['organization_id = ?', @contact_org.id]) 
			@attachments = @default_product.attachments
		end
  	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brlevel
      @brlevel = Brlevel.find(params[:id])
    end

end
