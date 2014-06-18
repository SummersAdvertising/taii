class FinancialreportsController < ApplicationController
  before_action :set_financialreport, only: [:show, :edit, :update, :destroy]

  # GET /financialreports
  # GET /financialreports.json
  def index
    @financialreports = Financialreport.all
  end

  # GET /financialreports/1
  # GET /financialreports/1.json
  def show
  end

  # GET /financialreports/new
  def new
    @financialreport = Financialreport.new
  end

  # GET /financialreports/1/edit
  def edit
  end

  # POST /financialreports
  # POST /financialreports.json
  def create
    @financialreport = Financialreport.new(financialreport_params)

    respond_to do |format|
      if @financialreport.save
        format.html { redirect_to @financialreport, notice: 'Financialreport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @financialreport }
      else
        format.html { render action: 'new' }
        format.json { render json: @financialreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /financialreports/1
  # PATCH/PUT /financialreports/1.json
  def update
    respond_to do |format|
      if @financialreport.update(financialreport_params)
        format.html { redirect_to @financialreport, notice: 'Financialreport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @financialreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /financialreports/1
  # DELETE /financialreports/1.json
  def destroy
    @financialreport.destroy
    respond_to do |format|
      format.html { redirect_to financialreports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financialreport
      @financialreport = Financialreport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def financialreport_params
      params.require(:financialreport).permit(:fiscal_year)
    end
end
