class BrlevelsController < ApplicationController
  before_action :set_brlevel, only: [:show, :edit, :update, :destroy]

  # GET /brlevels
  # GET /brlevels.json
  def index
    @brlevels = Brlevel.all
  end

  # GET /brlevels/1
  # GET /brlevels/1.json
  def show
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
        format.html { redirect_to @brlevel, notice: 'Brlevel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brlevel }
      else
        format.html { render action: 'new' }
        format.json { render json: @brlevel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brlevels/1
  # PATCH/PUT /brlevels/1.json
  def update
    respond_to do |format|
      if @brlevel.update(brlevel_params)
        format.html { redirect_to @brlevel, notice: 'Brlevel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brlevel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brlevels/1
  # DELETE /brlevels/1.json
  def destroy
    @brlevel.destroy
    respond_to do |format|
      format.html { redirect_to brlevels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brlevel
      @brlevel = Brlevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brlevel_params
      params.require(:brlevel).permit(:name, :level, :parent)
    end
end
