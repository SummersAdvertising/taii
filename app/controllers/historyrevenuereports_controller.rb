class HistoryrevenuereportsController < ApplicationController
  before_action :set_historyrevenuereport, only: [:show, :edit, :update, :destroy]

  # GET /historyrevenuereports
  # GET /historyrevenuereports.json
  def index
    @historyrevenuereports = Historyrevenuereport.all
  end

  # GET /historyrevenuereports/1
  # GET /historyrevenuereports/1.json
  def show
  end

  # GET /historyrevenuereports/new
  def new
    @historyrevenuereport = Historyrevenuereport.new
  end

  # GET /historyrevenuereports/1/edit
  def edit
  end

  # POST /historyrevenuereports
  # POST /historyrevenuereports.json
  def create
    @historyrevenuereport = Historyrevenuereport.new(historyrevenuereport_params)

    respond_to do |format|
      if @historyrevenuereport.save
        format.html { redirect_to @historyrevenuereport, notice: 'Historyrevenuereport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @historyrevenuereport }
      else
        format.html { render action: 'new' }
        format.json { render json: @historyrevenuereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historyrevenuereports/1
  # PATCH/PUT /historyrevenuereports/1.json
  def update
    respond_to do |format|
      if @historyrevenuereport.update(historyrevenuereport_params)
        format.html { redirect_to @historyrevenuereport, notice: 'Historyrevenuereport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @historyrevenuereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historyrevenuereports/1
  # DELETE /historyrevenuereports/1.json
  def destroy
    @historyrevenuereport.destroy
    respond_to do |format|
      format.html { redirect_to historyrevenuereports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historyrevenuereport
      @historyrevenuereport = Historyrevenuereport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historyrevenuereport_params
      params.require(:historyrevenuereport).permit(:fiscal_year)
    end
end
