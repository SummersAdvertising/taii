class MajorresolutionsController < ApplicationController
  before_action :set_majorresolution, only: [:show, :edit, :update, :destroy]

  # GET /majorresolutions
  # GET /majorresolutions.json
  def index
    @majorresolutions = Majorresolution.all
  end

  # GET /majorresolutions/1
  # GET /majorresolutions/1.json
  def show
  end

  # GET /majorresolutions/new
  def new
    @majorresolution = Majorresolution.new
  end

  # GET /majorresolutions/1/edit
  def edit
  end

  # POST /majorresolutions
  # POST /majorresolutions.json
  def create
    @majorresolution = Majorresolution.new(majorresolution_params)

    respond_to do |format|
      if @majorresolution.save
        format.html { redirect_to @majorresolution, notice: 'Majorresolution was successfully created.' }
        format.json { render action: 'show', status: :created, location: @majorresolution }
      else
        format.html { render action: 'new' }
        format.json { render json: @majorresolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /majorresolutions/1
  # PATCH/PUT /majorresolutions/1.json
  def update
    respond_to do |format|
      if @majorresolution.update(majorresolution_params)
        format.html { redirect_to @majorresolution, notice: 'Majorresolution was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @majorresolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /majorresolutions/1
  # DELETE /majorresolutions/1.json
  def destroy
    @majorresolution.destroy
    respond_to do |format|
      format.html { redirect_to majorresolutions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_majorresolution
      @majorresolution = Majorresolution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def majorresolution_params
      params.require(:majorresolution).permit(:fiscal_year)
    end
end
