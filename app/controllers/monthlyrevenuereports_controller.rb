class MonthlyrevenuereportsController < ApplicationController
  before_action :set_monthlyrevenuereport, only: [:show, :edit, :update, :destroy]

  # GET /monthlyrevenuereports
  # GET /monthlyrevenuereports.json
  def index
    @monthlyrevenuereports = Monthlyrevenuereport.all
  end

  # GET /monthlyrevenuereports/1
  # GET /monthlyrevenuereports/1.json
  def show
  end

  # GET /monthlyrevenuereports/new
  def new
    @monthlyrevenuereport = Monthlyrevenuereport.new
  end

  # GET /monthlyrevenuereports/1/edit
  def edit
  end

  # POST /monthlyrevenuereports
  # POST /monthlyrevenuereports.json
  def create
    @monthlyrevenuereport = Monthlyrevenuereport.new(monthlyrevenuereport_params)

    respond_to do |format|
      if @monthlyrevenuereport.save
        format.html { redirect_to @monthlyrevenuereport, notice: 'Monthlyrevenuereport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @monthlyrevenuereport }
      else
        format.html { render action: 'new' }
        format.json { render json: @monthlyrevenuereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monthlyrevenuereports/1
  # PATCH/PUT /monthlyrevenuereports/1.json
  def update
    respond_to do |format|
      if @monthlyrevenuereport.update(monthlyrevenuereport_params)
        format.html { redirect_to @monthlyrevenuereport, notice: 'Monthlyrevenuereport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @monthlyrevenuereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monthlyrevenuereports/1
  # DELETE /monthlyrevenuereports/1.json
  def destroy
    @monthlyrevenuereport.destroy
    respond_to do |format|
      format.html { redirect_to monthlyrevenuereports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthlyrevenuereport
      @monthlyrevenuereport = Monthlyrevenuereport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monthlyrevenuereport_params
      params.require(:monthlyrevenuereport).permit(:fiscal_year)
    end
end
