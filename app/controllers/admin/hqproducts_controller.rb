#encoding: utf-8
class Admin::HqproductsController < AdminController
	before_action :authenticate_admin!
  before_action :set_hqproduct, only: [:show, :edit, :update, :destroy, :create_attachment]
  before_action :check_accesslevel, only: [:edit,:update, :destroy, :create_attachment]
  # GET /hqproducts
  # GET /hqproducts.json
  def index
    @hqproducts = Hqproduct.all
  end

  # GET /hqproducts/1
  # GET /hqproducts/1.json
  def show
  end

  # GET /hqproducts/new
  def new
  	@hqproduct = Hqproduct.create()
  	@hqproduct.article = Article.new
  	@hqproduct.name = "新增產品#{Time.now.strftime("%Y-%m-%d-%I")}"
		@hqproduct.organization_id = 0
		
		if current_admin.superadmin == 1
			@hqproduct.accessLevel = 2
		else
			@hqproduct.accessLevel = 1		
		end
		
  	parentlevel = Hqlevel.find(params[:parentlevelid])
    parentlevel.hqproducts << @hqproduct

    #@hqproduct = Hqproduct.new(hqproduct_params)

    respond_to do |format|
      if @hqproduct.save
        format.html { redirect_to edit_admin_hqproduct_path(@hqproduct,locale: I18n.locale), notice: 'Hqproduct was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hqproduct }
      else
        format.html { render action: 'new' }
        format.json { render json: @hqproduct.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # GET /hqproducts/1/edit
  def edit
  	@breadcrumb = @hqproduct.hqlevel.find_my_direct_parent()
  	@Orgs = Organization.with_translations(I18n.locale)

  end

  # POST /hqproducts
  # POST /hqproducts.json
  def create
	@hqproduct = Hqproduct.create(hqproduct_params)
	@hqproduct.article = Article.new
	
  	parentlevel = Hqlevel.find(params[:hqlevel_id])
    parentlevel.hqproducts << @hqproduct

    #@hqproduct = Hqproduct.new(hqproduct_params)

    respond_to do |format|
      if @hqproduct.save
        format.html { redirect_to admin_hqlevel_path(parentlevel,locale: I18n.locale), notice: 'Hqproduct was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hqproduct }
      else
        format.html { render action: 'new' }
        format.json { render json: @hqproduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hqproducts/1
  # PATCH/PUT /hqproducts/1.json
  def update
  	@breadcrumb = @hqproduct.hqlevel.find_my_direct_parent()
  	@Orgs = Organization.with_translations(I18n.locale)
  	# force to set org_id to 0 if nil?
  	if hqproduct_params[:organization_id].empty?
  		params[:hqproduct][:organization_id] = 0
  	end
  	
    respond_to do |format|
      if @hqproduct.update(hqproduct_params) && ( params[ :article ].nil? ^ @hqproduct.article.update( params.require(:article).permit(:content) ) )
      
        format.html { redirect_to admin_hqlevel_path(@hqproduct.hqlevel, locale: I18n.locale), notice: 'Hqproduct was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hqproduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hqproducts/1
  # DELETE /hqproducts/1.json
  def destroy
    @hqproduct.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  #multiReorder
  def multiple_reorder
  	errorFlag = false
  	params[:hqproduct][:reorderset].each_with_index do | productid , index | 
  		@fProduct = Hqproduct.find(productid)
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
 			display_name = "#{@hqproduct.name}-附件-#{@hqproduct.attachments.count + 1}"
 		end
 		@latestAttach = Attachment.create(:attachment => params[:attachment], :attachable => @hqproduct, :file_name => display_name) if params[:attachment]
 		
 		respond_to do |format|
 				format.js
		  	 	format.json { head :no_content }
		  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hqproduct
      @hqproduct = Hqproduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hqproduct_params
      params.require(:hqproduct).permit(:name, :article_id, :hqlevel_id, :content, :showatfront, :organization_id, :accessLevel)
    end
    
    def check_accesslevel
    	if @hqproduct.accessLevel > current_admin.accessLevel
    		respond_to  do |format|
    			format.html { redirect_to admin_hqlevel_path( Hqlevel.return_root_node_on_demand(I18n.locale), locale: I18n.locale) }
    		end
    	end
    end
end
