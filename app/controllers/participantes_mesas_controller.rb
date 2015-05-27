class ParticipantesMesasController < ApplicationController
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
    if existe
      flash[:notice] = 'El participante ya se encuentra registrado para esta mesa'
      redirect_to existe
    else
      @participante_mesa = ParticipanteMesa.new(params[:participante_mesa])
      @participante_mesa.participante = Participante.find(p_id)
      @participante_mesa.mesa_de_trabajo = MesaDeTrabajo.find(m_id)

      respond_to do |format|
        if @participante_mesa.save
          flash[:notice] = 'Participante registrado con éxito.'
          format.html { redirect_to @participante_mesa }
          format.json { head :success }
        else
          format.html { render 'new.html.erb' }
          format.json { head :error }
        end
      end
    end
  end
  
  # GET /participantes_mesas/1
  # GET /participantes_mesas/1.json
  def show
    @participante_mesa = ParticipanteMesa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json => @participante_mesa }
    end
  end
  
  # DELETE /participantes_mesas/1
  # DELETE /participantes_mesas/1.json
  def destroy
    @participante_mesa = ParticipanteMesa.find(params[:id])
    cedula = @participante_mesa.participante.cedula
    @participante_mesa.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'participantes_mesas', :action => 'new', :entrada => entrada }
      format.json { head :ok }
    end
  end
  
  def mesasDisponibles
    MesaDeTrabajo.find(:all, :conditions => {:sorteada => false})
  end
end
