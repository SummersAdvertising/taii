class FinancialprojectionsController < ApplicationController
  before_action :set_financialprojection, only: [:show, :edit, :update, :destroy]

  # GET /financialprojections
  # GET /financialprojections.json
  def index
    @financialprojections = Financialprojection.all
  end

  # GET /financialprojections/1
  # GET /financialprojections/1.json
  def show
  end

  # GET /financialprojections/new
  def new
    @financialprojection = Financialprojection.new
  end

  # GET /financialprojections/1/edit
  def edit
  end

  # POST /financialprojections
  # POST /financialprojections.json
  def create
    @financialprojection = Financialprojection.new(financialprojection_params)

    respond_to do |format|
      if @financialprojection.save
        format.html { redirect_to @financialprojection, notice: 'Financialprojection was successfully created.' }
        format.json { render action: 'show', status: :created, location: @financialprojection }
      else
        format.html { render action: 'new' }
        format.json { render json: @financialprojection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /financialprojections/1
  # PATCH/PUT /financialprojections/1.json
  def update
    respond_to do |format|
      if @financialprojection.update(financialprojection_params)
        format.html { redirect_to @financialprojection, notice: 'Financialprojection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @financialprojection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /financialprojections/1
  # DELETE /financialprojections/1.json
  def destroy
    @financialprojection.destroy
    respond_to do |format|
      format.html { redirect_to financialprojections_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financialprojection
      @financialprojection = Financialprojection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def financialprojection_params
      params.require(:financialprojection).permit(:title, :article_id)
    end
end
