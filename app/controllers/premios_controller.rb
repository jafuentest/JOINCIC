class PremiosController < ApplicationController
  before_action :set_premio, only: [:show, :edit, :update, :destroy]

  # GET /premios
  # GET /premios.json
  def index
    @premios = Premio.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @premios }
    end
  end

  # GET /premios/1
  # GET /premios/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @premio }
    end
  end

  # GET /premios/new
  # GET /premios/new.json
  def new
    @premio = Premio.new
    @rifas = Rifa.all
    @patrocinantes = Patrocinante.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @premio }
    end
  end

  # GET /premios/1/edit
  def edit
    @rifas = Rifa.all
    @patrocinantes = Patrocinante.all
  end

  # POST /premios
  # POST /premios.json
  def create
    @premio = Premio.new(premio_params)
    @rifas = Rifa.all
    @patrocinantes = Patrocinante.all
    respond_to do |format|
      if @premio.save
        format.html { redirect_to @premio, notice: 'Premio was successfully created.' }
        format.json { render json: @premio, status: :created, location: @premio }
      else
        format.html { render "new.html.erb" }
        format.json { render json: @premio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /premios/1
  # PUT /premios/1.json
  def update
    respond_to do |format|
      if @premio.update_attributes(premio_params)
        format.html { redirect_to @premio, notice: 'Premio was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render "edit.html.erb" }
        format.json { render json: @premio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /premios/1
  # DELETE /premios/1.json
  def destroy
    @premio.destroy
    respond_to do |format|
      format.html { redirect_to premios_url }
      format.json { head :ok }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def premio_params
    params.require(:premio).permit(:nombre, :rifa_id, :participante_id, :patrocinante_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_premio
    @premio = Premio.find(params[:id])
  end
end
