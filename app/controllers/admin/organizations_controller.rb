class Admin::OrganizationsController < AdminController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.with_translations(I18n.locale)
    @neworg = Organization.new
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  	@representatives = Organization.with_representatives(@organization)
  	@newRep = Representative.new
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit

  end

  # POST /organizations
  # POST /organizations.json
  def create
	  @organization = Organization.new(organization_params)
 
		  respond_to do |format|
		    if @organization.save
		      
		      #work but causing not appendding new org to the list
		      #format.js   { render json: nil, status: :ok}
		      format.js  { render  :action => "create" }
		      format.json { render json: nil, status: :ok }
		      #format.html { redirect_to admin_organization_path(@organization,:locale=> I18n.locale) }
		    else
		      #format.html { render action: "new" }
  		      #format.js  { render js:  @organization.errors, :status => :unprocessable_entity  }
		      format.json { render json: @organization.errors.full_messages, status: :unprocessable_entity }
		    end
		  end

    # @organization = Organization.new(organization_params)
# 
#     respond_to do |format|
#       if @organization.save
#         format.html { redirect_to admin_organization_path(@organization), notice: 'Organization was successfully created.' }
#         format.json { render action: 'show', status: :created, location: @organization }
#       else
#         format.html { render action: 'new' }
#         format.json { render json: @organization.errors, status: :unprocessable_entity }
#       end
#     end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to admin_organizations_path(:locale => I18n.locale)}
	    format.json { head :no_content }
      else
        format.html { redirect_to admin_organization_path(@organization,locale: I18n.locale), notice: @organization.errors.full_messages }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to admin_organizations_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:org_name, :address, :accessLevel)
    end
end
