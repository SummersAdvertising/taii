class RevenueItemsController < ApplicationController
  before_action :set_revenue_item, only: [:show, :edit, :update, :destroy]

  # GET /revenue_items
  # GET /revenue_items.json
  def index
    @revenue_items = RevenueItem.all
  end

  # GET /revenue_items/1
  # GET /revenue_items/1.json
  def show
  end

  # GET /revenue_items/new
  def new
    @revenue_item = RevenueItem.new
  end

  # GET /revenue_items/1/edit
  def edit
  end

  # POST /revenue_items
  # POST /revenue_items.json
  def create
    @revenue_item = RevenueItem.new(revenue_item_params)

    respond_to do |format|
      if @revenue_item.save
        format.html { redirect_to @revenue_item, notice: 'Revenue item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @revenue_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @revenue_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revenue_items/1
  # PATCH/PUT /revenue_items/1.json
  def update
    respond_to do |format|
      if @revenue_item.update(revenue_item_params)
        format.html { redirect_to @revenue_item, notice: 'Revenue item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @revenue_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revenue_items/1
  # DELETE /revenue_items/1.json
  def destroy
    @revenue_item.destroy
    respond_to do |format|
      format.html { redirect_to revenue_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revenue_item
      @revenue_item = RevenueItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def revenue_item_params
      params.require(:revenue_item).permit(:fiscal_month, :item, :value, :ranking)
    end
end
