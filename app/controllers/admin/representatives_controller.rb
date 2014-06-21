#encoding: utf-8
class Admin::RepresentativesController < AdminController
  before_action :set_representative, only: [:show, :edit, :update, :destroy]

  # GET /representatives
  # GET /representatives.json
  def index
    @representatives = Representative.all
  end

  # GET /representatives/1
  # GET /representatives/1.json
  def show
  end

  # GET /representatives/new
  def new
    #@representative = Representative.new
    @organization = Organization.find(params[:organization_id])
    @representative = @organization.representatives.build(:organization_id => params[:organization_id])
  end

  # GET /representatives/1/edit
  def edit
  end

  # POST /representatives
  # POST /representatives.json
  def create
    @representative = Representative.new(representative_params)

    respond_to do |format|
      if @representative.save
        format.html { redirect_to admin_organization_path(@representative.organization,:locale => I18n.locale), notice: 'Representative was successfully created.' }
        format.json { render action: 'show', status: :created, location: @representative }
      else
        format.html { redirect_to admin_organization_path(@representative.organization,:locale => I18n.locale), flash: { newreperror: @representative.errors.full_messages} }
        format.json { render json: @representative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /representatives/1
  # PATCH/PUT /representatives/1.json
  def update
    respond_to do |format|
      if @representative.update(representative_params)
        format.html { redirect_to redirect_to admin_organization_path(@representative.organization,:locale => I18n.locale), notice: 'Representative was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @representative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /representatives/1
  # DELETE /representatives/1.json
  def destroy
    @representative.destroy
    respond_to do |format|
	      #format.js
	      format.html { redirect_to admin_organization_path(@representative.organization_id, locale: I18n.locale) }
	      format.json { render json: @representative.errors, status: :unprocessable_entity }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_representative
      @representative = Representative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def representative_params
		params.require(:representative).permit(:division, :name, :phone, :mobile, :email, :fax, :organization_id)
    end
end
