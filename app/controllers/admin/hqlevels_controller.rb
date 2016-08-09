class Admin::HqlevelsController < AdminController
	before_action :authenticate_admin!
  before_action :set_hqlevel, only: [:show, :edit, :update, :destroy]
  # GET /hqlevels
  # GET /hqlevels.json
  def index
    @hqlevels = Hqlevel.with_translations(I18n.locale)
  end

  # GET /hqlevels/1
  # GET /hqlevels/1.json
  def show
	#@hqlevelsRoot = Hqlevel.new.return_root_node()
	#@hqlevels = @hqlevelsRoot.descendents()
	@newhqlevel = Hqlevel.new
	#@breadcrumb = @hqlevel.find_my_direct_parent().load#@hqlevel.findpapa
	@breadcrumb = @hqlevel.find_my_direct_parent
	@productsofthislevel = Hqlevel.with_products(@hqlevel)
	@directchildrent = @hqlevel.find_my_direct_childrent.load
	#change find_each?
  end

  # GET /hqlevels/new
  def new
    @hqlevel = Hqlevel.new
  end

  # GET /hqlevels/1/edit
  def edit
  end

  # POST /hqlevels
  # POST /hqlevels.json
  def create
	  	 @hqlevel = Hqlevel.new(hqlevel_params)
 
		  respond_to do |format|
		    if @hqlevel.save
		      format.html #{ redirect_to @hqlevel, notice: 'User was successfully created.' }
		      format.js   
		      format.json { render json: @hqlevel, status: :created, location: @hqlevel }
		    else
		      format.json { render json: @hqlevel.errors.full_messages, status: :unprocessable_entity }
		    end
		  end
	  	#--
	    #@hqlevel = Hqlevel.new(hqlevel_params)
	
#	    respond_to do |format|
# 	      if @hqlevel.save
# 	        format.html { redirect_to admin_hqlevel_path(@hqlevel.parent), notice: 'Hqlevel was successfully created.' }
# 	        format.json { render action: 'show', status: :created, location: @hqlevel }
# 	      else
# 	        format.html { render action: 'new' }
# 	        format.json { render json: @hqlevel.errors, status: :unprocessable_entity }
# 	      end
# 	    end
	    
	  end
	
	  # PATCH/PUT /hqlevels/1
	  # PATCH/PUT /hqlevels/1.json
	  def update
		respond_to do |format|
		    if @hqlevel.update(hqlevel_params)
	 	      format.html #{ redirect_to @hqlevel, notice: 'Hqlevel was successfully updated.' }
		      format.js   
		      format.json { head :no_content }
		    else
		      format.html #{ render action: "" }
		      format.json { render json: @hqlevel.errors, status: :unprocessable_entity }
		    end
		  end	  
# 	    respond_to do |format|
# 	      if @hqlevel.update(hqlevel_params)
# 	        format.html { redirect_to @hqlevel, notice: 'Hqlevel was successfully updated.' }
# 	        format.json { head :no_content }
# 	      else
# 	        format.html { render action: 'edit' }
# 	        format.json { render json: @hqlevel.errors, status: :unprocessable_entity }
# 	      end
# 	    end
	  end
	
	  # DELETE /hqlevels/1
	  # DELETE /hqlevels/1.json
	  def destroy

			@hqlevel.destroy
	    respond_to do |format|
	      format.js
	      format.html #{ redirect_to admin_hqlevel_path(@hqlevel.parent) }
	      format.json { render json: @hqlevel.errors, status: :unprocessable_entity }
	    end

	  end
  
   #multiReorder
	  def multiple_reorder
	  	errorFlag = false
	  	params[:hqlevel][:reorderset].each_with_index do | levelid , index | 
	  		@hqlevel = Hqlevel.find(levelid)
	  		if !@hqlevel.nil?
	  			@hqlevel.update_attribute(:ranking , index+1 )
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
    def set_hqlevel
      @hqlevel = Hqlevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hqlevel_params
      params.require(:hqlevel).permit(:name, :level, :parent, :ranking, :reorderset, :locale,:chaos)
    end
        
end
