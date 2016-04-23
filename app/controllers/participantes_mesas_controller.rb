class ParticipantesMesasController < ApplicationController
  skip_before_filter :organizadorLogin, only: [:create, :new]
  before_action :set_participante_mesa, only: [:show, :destroy]

  # GET /participantes_mesas/new
  # GET /participantes_mesas/new.json
  def new
    numero_regex = /^[0-9]+$/
    error = ''
    cedula = params[:cedula]

    unless cedula =~ numero_regex
      error = 'Error: Número de cédula inválido'
      cedula = ''
    end

    unless params.has_key?(:cedula) && cedula != ''
      error = 'Ingresa el número de cédula del participante'
    end

    @participante = Participante.find_by_cedula(cedula)
    if @participante.nil?
      error = 'No se encontró ningún participante cuyo número de cédula sea: ' + cedula
    elsif @participante.eliminado
      error = 'Error: El participante fue eliminado del sistema'
    else
      @mesas_de_trabajo = mesasDisponibles
      @participante_mesa = ParticipanteMesa.new
    end
    respond_to do |format|
      if error == ''
        format.html { render 'new.html.erb' }
      else
        flash[:notice] = error
        format.html { redirect_to buscar_participantes_mesas_path }
      end
    end
  end

  # POST /participantes_mesas
  # POST /participantes_mesas.json
  def create
    p_id = params[:participante_mesa][:participante_id]
    m_id = params[:participante_mesa][:mesa_de_trabajo_id]
    existe = ParticipanteMesa.find_by_participante_id_and_mesa_de_trabajo_id(p_id, m_id)
    respond_to do |format|
      if existe
        flash[:notice] = 'El participante ya se encuentra registrado para esta mesa'
        format.html { render 'new.html.erb' }
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
          format.html { render 'new.html.erb' }
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
    cedula = @participante_mesa.participante.cedula
    @participante_mesa.destroy
    respond_to do |format|
      format.html { redirect_to controller: 'participantes_mesas', action: 'new', entrada: entrada }
      format.json { head :ok }
    end
  end

  def mesasDisponibles
    MesaDeTrabajo.find(:all, conditions: { sorteada: false })
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def participante_mesa_params
    params.require(:participante_mesa).permit(:participante_id, :mesa_de_trabajo_id)
  end
end
