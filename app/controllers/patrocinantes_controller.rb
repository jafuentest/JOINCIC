class PatrocinantesController < ApplicationController
  before_action :set_patrocinante, only: [:show, :edit, :update, :destroy]

  # GET /patrocinantes
  # GET /patrocinantes.json
  def index
    @patrocinantes = Patrocinante.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patrocinantes }
    end
  end

  # GET /patrocinantes/1
  # GET /patrocinantes/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patrocinante }
    end
  end

  # GET /patrocinantes/new
  # GET /patrocinantes/new.json
  def new
    @patrocinante = Patrocinante.new
    @planes = Plan.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patrocinante }
    end
  end

  # GET /patrocinantes/1/edit
  def edit
    @planes = Plan.all
  end

  # POST /patrocinantes
  # POST /patrocinantes.json
  def create
    @patrocinante = Patrocinante.new(patrocinante_params)
    @planes = Plan.all
    respond_to do |format|
      if @patrocinante.save
        format.html { redirect_to @patrocinante, notice: 'Patrocinante was successfully created.' }
        format.json { render json: @patrocinante, status: :created, location: @patrocinante }
      else
        format.html { render 'new.html.erb' }
        format.json { render json: @patrocinante.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /patrocinantes/1
  # PUT /patrocinantes/1.json
  def update
    @planes = Plan.all
    respond_to do |format|
      if @patrocinante.update_attributes(patrocinante_params)
        format.html { redirect_to @patrocinante, notice: 'Patrocinante was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render 'edit.html.erb' }
        format.json { render json: @patrocinante.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patrocinantes/1
  # DELETE /patrocinantes/1.json
  def destroy
    @patrocinante.destroy
    respond_to do |format|
      format.html { redirect_to patrocinantes_url }
      format.json { head :ok }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def patrocinante_params
    params.require(:patrocinante).permit(:id, :rif, :nombre, :aporte, :plan_id, :comentario, :logo)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_patrocinante
    @patrocinante = Patrocinante.find(params[:id])
  end
end
