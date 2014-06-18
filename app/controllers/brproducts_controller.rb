class BrproductsController < ApplicationController
  before_action :set_brproduct, only: [:show, :edit, :update, :destroy]

  # GET /brproducts
  # GET /brproducts.json
  def index
    @brproducts = Brproduct.all
  end

  # GET /brproducts/1
  # GET /brproducts/1.json
  def show
  end

  # GET /brproducts/new
  def new
    @brproduct = Brproduct.new
  end

  # GET /brproducts/1/edit
  def edit
  end

  # POST /brproducts
  # POST /brproducts.json
  def create
    @brproduct = Brproduct.new(brproduct_params)

    respond_to do |format|
      if @brproduct.save
        format.html { redirect_to @brproduct, notice: 'Brproduct was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brproduct }
      else
        format.html { render action: 'new' }
        format.json { render json: @brproduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brproducts/1
  # PATCH/PUT /brproducts/1.json
  def update
    respond_to do |format|
      if @brproduct.update(brproduct_params)
        format.html { redirect_to @brproduct, notice: 'Brproduct was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brproduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brproducts/1
  # DELETE /brproducts/1.json
  def destroy
    @brproduct.destroy
    respond_to do |format|
      format.html { redirect_to brproducts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brproduct
      @brproduct = Brproduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brproduct_params
      params.require(:brproduct).permit(:name, :article_id, :brlevel_id)
    end
end
