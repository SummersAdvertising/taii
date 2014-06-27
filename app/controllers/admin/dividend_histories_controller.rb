class Admin::DividendHistoriesController < AdminController
  before_action :set_dividend_history, only: [:show, :edit, :update, :destroy]

  # GET /dividend_histories
  # GET /dividend_histories.json
  def index
    @dividend_histories = DividendHistory.all
    @Newhistory = DividendHistory.new
  end

  # GET /dividend_histories/1
  # GET /dividend_histories/1.json
  def show
  end

  # GET /dividend_histories/new
  def new
    @dividend_history = DividendHistory.new
  end

  # GET /dividend_histories/1/edit
  def edit
  end

  # POST /dividend_histories
  # POST /dividend_histories.json
  def create
    @dividend_history = DividendHistory.new(dividend_history_params)

    respond_to do |format|
      if @dividend_history.save
        format.html { redirect_to admin_dividend_histories_path, notice: 'Dividend history was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dividend_history }
      else
        format.html { redirect_to admin_dividend_histories_path, flash: { notice: @dividend_history.errors.full_messages } }
        format.json { render json: @dividend_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dividend_histories/1
  # PATCH/PUT /dividend_histories/1.json
  def update
    respond_to do |format|
      if @dividend_history.update(dividend_history_params)
        format.html { redirect_to admin_dividend_histories_path, notice: 'Dividend history was successfully updated.' }
        format.json { head :no_content }
      else
	      format.html { redirect_to admin_dividend_histories_path, flash: { notice: @dividend_history.errors.full_messages } }
        format.json { render json: @dividend_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dividend_histories/1
  # DELETE /dividend_histories/1.json
  def destroy
    @dividend_history.destroy
    respond_to do |format|
      format.html { redirect_to admin_dividend_histories_path }
      format.json { head :no_content }
    end
  end
  
  #multiReorder
	  def multiple_reorder
	  	errorFlag = false
	  	params[:dividend_histories][:reorderset].each_with_index do | levelid , index | 
	  		@dividend_history = DividendHistory.find(levelid)
	  		if !@dividend_history.nil?
	  			@dividend_history.update_attribute(:ranking , index+1 )
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dividend_history
      @dividend_history = DividendHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dividend_history_params
      params.require(:dividend_history).permit(:fiscal_year, :sre, :scap, :cash, :total, :stock_paymentdate, :cash_paymentdate)
    end
end
