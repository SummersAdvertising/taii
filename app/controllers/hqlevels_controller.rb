class HqlevelsController < ApplicationController
  before_action :set_hqlevel, only: [:show, :edit, :update, :destroy]

  # GET /hqlevels
  # GET /hqlevels.json
  def index
    @hqlevels = Hqlevel.all
  end

  # GET /hqlevels/1
  # GET /hqlevels/1.json
  def show
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
        format.html { redirect_to @hqlevel, notice: 'Hqlevel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hqlevel }
      else
        format.html { render action: 'new' }
        format.json { render json: @hqlevel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hqlevels/1
  # PATCH/PUT /hqlevels/1.json
  def update
    respond_to do |format|
      if @hqlevel.update(hqlevel_params)
        format.html { redirect_to @hqlevel, notice: 'Hqlevel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hqlevel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hqlevels/1
  # DELETE /hqlevels/1.json
  def destroy
    @hqlevel.destroy
    respond_to do |format|
      format.html { redirect_to hqlevels_url }
      format.json { head :no_content }
    end
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
