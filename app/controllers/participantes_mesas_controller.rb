class ParticipantesMesasController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  skip_before_filter :organizadorLogin, only: [:create, :new]
  before_action :set_participante_mesa, only: [:show, :destroy]

  # GET /participantes_mesas/new
  # GET /participantes_mesas/new.json
  def new
    numero_regex = /^[0-9]+$/
    error = ''
    cedula = params[:cedula]

    if params.has_key?(:cedula) && cedula != ''
      if cedula =~ numero_regex
        @participante = Participante.find_by_cedula(cedula)
        if @participante.nil?
          error = 'No se encontró ningún participante cuyo número de cédula sea: ' + cedula
        elsif @participante.eliminado
          error = 'Error: El participante fue eliminado del sistema'
        else
          @mesas_de_trabajo = mesasDisponibles
          @participante_mesa = ParticipanteMesa.new
        end
      else
        error = 'Error: Número de cédula inválido'
        cedula = ''
      end
    else
      error = 'Ingresa el número de cédula del participante'
    end

    respond_to do |format|
      if error == ''
        format.html { render 'new' }
      else
        flash[:notice] = error
        format.html { redirect_to buscar_participantes_mesas_path }
      end
    end
  end

  # POST /participantes_mesas
  # POST /participantes_mesas.json
  def create
    p_id = participante_mesa_params[:participante_id]
    m_id = participante_mesa_params[:mesa_de_trabajo_id]
    existe = ParticipanteMesa.find_by_participante_id_and_mesa_de_trabajo_id(p_id, m_id)
    respond_to do |format|
      if existe
        @participante_mesa = ParticipanteMesa.new(participante_mesa_params)
        @mesas_de_trabajo = mesasDisponibles
        @participante = Participante.find(p_id)
        flash[:notice] = 'El participante ya se encuentra registrado para esta mesa'
        format.html { render 'new' }
        format.json { head :conflict }
      else
        @participante_mesa = ParticipanteMesa.new(participante_mesa_params)
        p = Participante.find_by_id(p_id)
        m = MesaDeTrabajo.find_by_id(m_id)
        if !p.nil? && !m.nil? && @participante_mesa.save
          flash[:notice] = 'Participante registrado con éxito'
          format.html { redirect_to @participante_mesa }
          format.json { head :ok }
        else
          error = 'Ha ocurrido un error'
          flash[:notice] = error
          format.html { render 'new' }
          format.json { head :error }
        end
      end
    end
  end

  # GET /participantes_mesas/1
  # GET /participantes_mesas/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participante_mesa }
    end
  end

  # DELETE /participantes_mesas/1
  # DELETE /participantes_mesas/1.json
  def destroy
    @mesas_de_trabajo = mesasDisponibles
    @participante = @participante_mesa.participante
    @participante_mesa.destroy
    flash[:notice] = 'Inscripción eliminada con éxito'
    
    respond_to do |format|
      format.html { render 'new' }
      format.json { head :ok }
    end
  end

  private

  def mesasDisponibles
    MesaDeTrabajo.where(sorteada: false)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participante_mesa_params
    params.require(:participante_mesa).permit(:participante_id, :mesa_de_trabajo_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_participante_mesa
    @participante_mesa = ParticipanteMesa.find(params[:id])
  end
end
