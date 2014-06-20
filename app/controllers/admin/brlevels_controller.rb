class Admin::BrlevelsController < AdminController
		before_action :authenticate_admin!
    before_action :set_brlevel, only: [:show, :edit, :update, :destroy]

  # GET /brlevels
  # GET /brlevels.json
  def index
    @brlevels = Brlevel.with_translations(I18n.locale)
  end

  # GET /brlevels/1
  # GET /brlevels/1.json
  def show
	@newbrlevel = Brlevel.new
	@breadcrumb = @brlevel.find_my_direct_parent.reverse
	@productsofthislevel =  Brlevel.with_products(@brlevel)
	@directchildrent = @brlevel.find_my_direct_childrent.load
	
  end

  # GET /brlevels/new
  def new
    @brlevel = Brlevel.new
  end

  # GET /brlevels/1/edit
  def edit
  end

  # POST /brlevels
  # POST /brlevels.json
  def create
	  	
	  	 @brlevel = Brlevel.new(brlevel_params)
 
		  respond_to do |format|
		    if @brlevel.save
		      format.html #{ redirect_to @brlevel, notice: 'User was successfully created.' }
		      format.js   
		      format.json { render json: @brlevel, status: :created, location: @brlevel }
		    else
		      #format.html { render action: "new" }
		      format.json { render json: @brlevel.errors, status: :unprocessable_entity }
		    end
		  end
	  	#--
	    #@brlevel = Brlevel.new(brlevel_params)
	
#	    respond_to do |format|
# 	      if @brlevel.save
# 	        format.html { redirect_to admin_brlevel_path(@brlevel.parent), notice: 'Brlevel was successfully created.' }
# 	        format.json { render action: 'show', status: :created, location: @brlevel }
# 	      else
# 	        format.html { render action: 'new' }
# 	        format.json { render json: @brlevel.errors, status: :unprocessable_entity }
# 	      end
# 	    end
	    
	  end
	
	  # PATCH/PUT /brlevels/1
	  # PATCH/PUT /brlevels/1.json
	  def update
		respond_to do |format|
		    if @brlevel.update(brlevel_params)
	 	      format.html #{ redirect_to @brlevel, notice: 'Brlevel was successfully updated.' }
		      format.js   
		      format.json { head :no_content }
		    else
		      format.html #{ render action: "" }
		      format.json { render json: @brlevel.errors, status: :unprocessable_entity }
		    end
		  end	  
# 	    respond_to do |format|
# 	      if @brlevel.update(brlevel_params)
# 	        format.html { redirect_to @brlevel, notice: 'Brlevel was successfully updated.' }
# 	        format.json { head :no_content }
# 	      else
# 	        format.html { render action: 'edit' }
# 	        format.json { render json: @brlevel.errors, status: :unprocessable_entity }
# 	      end
# 	    end
	  end
	
	  # DELETE /brlevels/1
	  # DELETE /brlevels/1.json
	  def destroy
	    @brlevel.destroy
	    respond_to do |format|
	      format.js
	      format.html #{ redirect_to admin_brlevel_path(@brlevel.parent) }
	      format.json { render json: @brlevel.errors, status: :unprocessable_entity }
	    end
	  end
  
   #multiReorder
	  def multiple_reorder
	  	errorFlag = false
	  	params[:brlevel][:reorderset].each_with_index do | levelid , index | 
	  		@brlevel = Brlevel.find(levelid)
	  		if !@brlevel.nil?
	  			@brlevel.update_attribute(:ranking , index+1 )
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
    def set_brlevel
      @brlevel = Brlevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brlevel_params
      params.require(:brlevel).permit(:name, :level, :parent, :ranking, :reorderset, :locale, :chaos)
    end
end
