#encoding: utf-8
class Admin::BrproductsController < AdminController
	before_action :authenticate_admin!
	before_action :set_brproduct, only: [:show, :edit, :update, :destroy, :create_attachment]
  before_action :check_accesslevel, only: [:edit,:update, :destroy, :create_attachment]
  # GET /brproducts
  # GET /brproducts.json
  def index
    @brproducts = Brproduct.all
  end

  # GET /brproducts/1
  # GET /brproducts/1.json
  def show
  end

  # GET /brproducts/new
  def new
  	@brproduct = Brproduct.create()
  	@brproduct.article = Article.new
  	@brproduct.name = "新增產品#{Time.now.strftime("%Y-%m-%d-%I")}"
		@brproduct.organization_id = 0
		
  	parentlevel = Brlevel.find(params[:parentlevelid])
    parentlevel.brproducts << @brproduct

    #@brproduct = Brproduct.new(brproduct_params)

    respond_to do |format|
      if @brproduct.save
        format.html { redirect_to edit_admin_brproduct_path(@brproduct,locale: I18n.locale), notice: 'Brproduct was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brproduct }
      else
        format.html { render action: 'new' }
        format.json { render json: @brproduct.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # GET /brproducts/1/edit
  def edit
  	@breadcrumb = @brproduct.brlevel.find_my_direct_parent()
  	@Orgs = Organization.with_translations(I18n.locale)

  end

  # POST /brproducts
  # POST /brproducts.json
  def create

	@brproduct = Brproduct.create(brproduct_params)
	@brproduct.article = Article.new
	
  	parentlevel = Hqlevel.find(params[:brlevel_id])
    parentlevel.brproducts << @brproduct

    #@brproduct = Brproduct.new(brproduct_params)

    respond_to do |format|
      if @brproduct.save
        format.html { redirect_to admin_brlevel_path(parentlevel,locale: I18n.locale), notice: 'Brproduct was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brproduct }
      else
        format.html { render action: 'new' }
        format.json { render json: @brproduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brproducts/1
  # PATCH/PUT /brproducts/1.json
  def update
  	@breadcrumb = @brproduct.brlevel.find_my_direct_parent()
  	@Orgs = Organization.with_translations(I18n.locale)
  	# force to set org_id to 0 if nil?
  	if brproduct_params[:organization_id].empty?
  		params[:brproduct][:organization_id] = 0
  	end
  	
    respond_to do |format|
      if @brproduct.update(brproduct_params) && ( params[ :article ].nil? ^ @brproduct.article.update( params.require(:article).permit(:content) ) )
      
        format.html { redirect_to admin_brlevel_path(@brproduct.brlevel, locale: I18n.locale), notice: 'Brproduct was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brproduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brproducts/1
  # DELETE /brproducts/1.json
  def destroy
    @brproduct.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  #multiReorder
  def multiple_reorder
  	errorFlag = false
  	params[:brproduct][:reorderset].each_with_index do | productid , index | 
  		@fProduct = Brproduct.find(productid)
  		if !@fProduct.nil?
  			@fProduct.update_attribute(:ranking , index+1 )
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
  
  def create_attachment
  		#deal with attachment
 		if params[:filename].present? 
 			display_name = params[:filename] 
 		else 
 			display_name = "#{@brproduct.name}-附件-#{@brproduct.attachments.count + 1}"
 		end
 		@latestAttach = Attachment.create(:attachment => params[:attachment], :attachable => @brproduct, :file_name => display_name) if params[:attachment]
 		
 		respond_to do |format|
 				format.js
		  	 	format.json { head :no_content }
		  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brproduct
      @brproduct = Brproduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brproduct_params
      params.require(:brproduct).permit(:name, :article_id, :brlevel_id, :content, :hide, :organization_id, :accessLevel)
    end

    def check_accesslevel
    	if @brproduct.accessLevel > current_admin.accessLevel
    		respond_to  do |format|
    			format.html { redirect_to admin_brlevel_path( Brlevel.return_root_node_on_demand(I18n.locale), locale: I18n.locale) }
    		end
    	end
    end

end
