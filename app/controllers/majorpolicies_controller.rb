class MajorpoliciesController < ApplicationController
  before_action :set_majorpolicy, only: [:show, :edit, :update, :destroy]

  # GET /majorpolicies
  # GET /majorpolicies.json
  def index
    @majorpolicies = Majorpolicy.all
  end

  # GET /majorpolicies/1
  # GET /majorpolicies/1.json
  def show
  end

  # GET /majorpolicies/new
  def new
    @majorpolicy = Majorpolicy.new
  end

  # GET /majorpolicies/1/edit
  def edit
  end

  # POST /majorpolicies
  # POST /majorpolicies.json
  def create
    @majorpolicy = Majorpolicy.new(majorpolicy_params)

    respond_to do |format|
      if @majorpolicy.save
        format.html { redirect_to @majorpolicy, notice: 'Majorpolicy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @majorpolicy }
      else
        format.html { render action: 'new' }
        format.json { render json: @majorpolicy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /majorpolicies/1
  # PATCH/PUT /majorpolicies/1.json
  def update
    respond_to do |format|
      if @majorpolicy.update(majorpolicy_params)
        format.html { redirect_to @majorpolicy, notice: 'Majorpolicy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @majorpolicy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /majorpolicies/1
  # DELETE /majorpolicies/1.json
  def destroy
    @majorpolicy.destroy
    respond_to do |format|
      format.html { redirect_to majorpolicies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_majorpolicy
      @majorpolicy = Majorpolicy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def majorpolicy_params
      params.require(:majorpolicy).permit(:description)
    end
end
