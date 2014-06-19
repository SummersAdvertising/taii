#encoding: utf-8
class Admin::RevenueItemsController < AdminController
  before_action :set_revenue_item, only: [:show, :update, :destroy]
  before_action :defaultItems, onle: [:createDefaultItems]
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
  	#從monthlyrevenuereport 來的時候會給定 id 所以只需要做一個 針對個別修改即可
  	
  	# @monthlyRRpt = Monthlyrevenuereport.find(params[:id]) if !params[:id].nil?
#   	if !@monthlyRRpt.nil?
# 	  	@revenue_items = RevenueItem.where('fiscal_month='+params[:fiscal_month].to_s)
#   	else
#   	
#   	end
  
  end

  # POST /revenue_items
  # POST /revenue_items.json
  def create
    @revenue_item = RevenueItem.new(revenue_item_params)
    
    respond_to do |format|
      if @revenue_item.save
      	format.js
        #format.html { redirect_to @revenue_item, notice: 'Revenue item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @revenue_item }
      else
        format.html { redirect_to editbymonth_admin_monthlyrevenuereport_path(@revenue_item.monthlyrevenuereport_id, fiscal_month: @revenue_item.fiscal_month), notice: 'Oops, something went wrong.' }
        format.json { render json: @revenue_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revenue_items/1
  # PATCH/PUT /revenue_items/1.json
  def update
    respond_to do |format|
      if @revenue_item.update(revenue_item_params)
        format.html { redirect_to editbymonth_admin_monthlyrevenuereport_path(@revenue_item.monthlyrevenuereport_id, fiscal_month: @revenue_item.fiscal_month), notice: 'Revenue item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to editbymonth_admin_monthlyrevenuereport_path(@revenue_item.monthlyrevenuereport_id, fiscal_month: @revenue_item.fiscal_month), notice: 'Oops, something went wrong.' }
        format.json { render json: @revenue_item.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revenue_items/1
  # DELETE /revenue_items/1.json
  def destroy
    @revenue_item.destroy
    respond_to do |format|
      format.html { redirect_to editbymonth_admin_monthlyrevenuereport_path(@revenue_item.monthlyrevenuereport_id, fiscal_month: @revenue_item.fiscal_month) }
      format.json { head :no_content }
    end
  end

  #multiReorder
  def multiple_reorder
  	errorFlag = false
  	params[:revenue_item][:reorderset].each_with_index do | itemid , index | 
  		@fItem = RevenueItem.find(itemid)
  		if !@fItem.nil?
  			@fItem.update_attribute(:ranking , index+1 )
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
  
  #createDefaultItems
  def createDefaultItems
	  	
	@revenueItems.each do | item |
		item.reverse_merge!(monthlyrevenuereport_id: params[:report_id] ,fiscal_month: params[:fiscal_month] )
	end	  	
	RevenueItem.create(@revenueItems)
	  	
	respond_to do |format|
		 	format.html { redirect_to editbymonth_admin_monthlyrevenuereport_path(params[:report_id], fiscal_month: params[:fiscal_month]) }
	end
	  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revenue_item
      @revenue_item = RevenueItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def revenue_item_params
      params.require(:revenue_item).permit(:fiscal_month, :item, :value, :ranking, :monthlyrevenuereport_id)
    end
    
    def defaultItems
    	#k-v pair: item:value
    	@revenueItems = [
    	{item: '本月', value: '0.0'},
    	{item: '去年同期', value: '0.0'},
    	{item: '增減金額',value: '0.0'},
    	{item: '增減百分比',value: '0.0'},
    	{item: '本年累計',value: '0.0'},
    	{item: '去年累計', value:'0.0'},
    	{item: '增減金額',value: '0.0'},
    	{item: '增減百分比',value: '0.0'}]
    end
end
