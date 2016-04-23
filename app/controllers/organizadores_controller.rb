class OrganizadoresController < ApplicationController
  before_action :set_organizador, only: [:show, :edit, :update, :destroy]

  # GET /organizadores
  # GET /organizadores.json
  def index
    @organizadores = Organizador.paginate per_page: 20, page: params[:page], conditions: { eliminado: nil }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizadores }
    end
  end

  # GET /organizadores/1
  # GET /organizadores/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organizador }
    end
  end

  # GET /organizadores/new
  # GET /organizadores/new.json
  def new
    @organizador = Organizador.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organizador }
    end
  end

  # GET /organizadores/1/edit
  def edit
    if @organizador.id != session[:usuario_id] && session[:usuario_id] != 1
      flash[:notice] = 'Usted no tiene privilegios para modificar otros usuarios'
      redirect_to @organizador
    end
  end

  # POST /organizadores
  # POST /organizadores.json
  def create
    @organizador = Organizador.new(organizador_params)
    respond_to do |format|
      if @organizador.save
        format.html { redirect_to @organizador }
        format.json { render json: @organizador, status: :created, location: @organizador }
      else
        format.html { render 'new.html.erb' }
        format.json { render json: @organizador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizadores/1
  # PUT /organizadores/1.json
  def update
    respond_to do |format|
      if @organizador.update_attributes(organizador_params)
        format.html { redirect_to @organizador }
        format.json { head :ok }
      else
        format.html { render 'edit.html.erb' }
        format.json { render json: @organizador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizadores/1
  # DELETE /organizadores/1.json
  def destroy
    @organizador.update_attribute(:eliminado, true)
    logger.warn "#{session[:organizador]} ha eliminado a: #{@organizador.nombreCompleto}"
    respond_to do |format|
      format.html { redirect_to organizadores_url }
      format.json { head :ok }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def organizador_params
    params.require(:organizador).permit(:usuario, :clave, :nombre, :apellido, :correo,
      :institucion, :coordinacion, :coordinador, :seg_nombre, :seg_apellido, :eliminado)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_organizador
    @organizador = Organizador.find(params[:id])
  end
end
