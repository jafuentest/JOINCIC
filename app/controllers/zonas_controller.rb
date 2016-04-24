class ZonasController < ApplicationController
  before_action :set_zona, only: [:show, :edit, :update, :destroy]

  # GET /zonas
  # GET /zonas.json
  def index
    @zonas = Zona.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @zonas }
    end
  end

  # GET /zonas/1
  # GET /zonas/1.json
  def show
    @disponibilidad = @zona.capacidad - @zona.participantes.count
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @zona }
    end
  end

  # GET /zonas/new
  # GET /zonas/new.json
  def new
    @zona = Zona.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @zona }
    end
  end

  # GET /zonas/1/edit
  def edit
  end

  # POST /zonas
  # POST /zonas.json
  def create
    @zona = Zona.new(zona_params)
    respond_to do |format|
      if @zona.save
        format.html { redirect_to @zona, notice: 'Zona was successfully created.' }
        format.json { render json: @zona, status: :created, location: @zona }
      else
        format.html { render 'new.html.erb' }
        format.json { render json: @zona.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /zonas/1
  # PUT /zonas/1.json
  def update
    respond_to do |format|
      if @zona.update_attributes(zona_params)
        format.html { redirect_to @zona, notice: 'Zona was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render 'edit.html.erb' }
        format.json { render json: @zona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zonas/1
  # DELETE /zonas/1.json
  def destroy
    @zona.destroy
    respond_to do |format|
      format.html { redirect_to zonas_url }
      format.json { head :ok }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def zona_params
    params.require(:zona).permit(:nombre, :capacidad)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_zona
    @zona = Zona.find(params[:id])
  end
end
