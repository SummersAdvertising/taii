class HqproductsController < ApplicationController
  before_action :set_hqproduct, only: [:show, :edit, :update, :destroy]

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
    @hqproduct = Hqproduct.new
  end

  # GET /hqproducts/1/edit
  def edit
  end

  # POST /hqproducts
  # POST /hqproducts.json
  def create
    @hqproduct = Hqproduct.new(hqproduct_params)

    respond_to do |format|
      if @hqproduct.save
        format.html { redirect_to @hqproduct, notice: 'Hqproduct was successfully created.' }
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
    respond_to do |format|
      if @hqproduct.update(hqproduct_params)
        format.html { redirect_to @hqproduct, notice: 'Hqproduct was successfully updated.' }
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
      format.html { redirect_to hqproducts_url }
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
      params.require(:hqproduct).permit(:name, :article_id, :hqlevel_id)
    end
end
