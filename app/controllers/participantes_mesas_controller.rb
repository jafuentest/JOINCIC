class ParticipantesMesasController < ApplicationController
  # GET /participantes_mesas
  # GET /participantes_mesas.json
  def index
    if params.has_key?(:cedula) && params[:cedula] != ""
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @participantes_mesas }
      end
    else
      flash[:notice] = "Ingresa el número de cédula del participante"
      redirect_to buscar_participantes_mesas_path
    end
  end

  # GET /participantes_mesas/1
  # GET /participantes_mesas/1.json
  def show
    numero_regex = /^[0-9]+$/
    
    if params[:id] =~ numero_regex
      @participante = Participante.find_by_cedula(params[:id])
      
      if @participante.nil?
        flash[:notice] = "No se encontró ningún participante cuya cédula sea: <br/>".html_safe + params[:id]
        redirect_to buscar_participantes_mesas_path
      else
        @participantes_mesas = @participante.participantes_mesas
        
        if @participante.eliminado
          flash[:notice] = "Error: El participante fue eliminado del sistema"
          redirect_to buscar_participantes_mesas_path
        else
          respond_to do |format|
            if @participantes_mesas.size > 0
              format.html { render action: "index" }
            else
              @mesas_de_trabajo = MesasDeTrabajo.all
              format.html { render action: "new" }
            end
          end
        end
      end
    
    else
      flash[:notice] = "Error: Número de cédula inválido"
      redirect_to buscar_participantes_mesas_path
    end
  end

  # GET /participantes_mesas/new
  # GET /participantes_mesas/new.json
  def new
    @participante = Participante.find_by_cedula(params[:cedula])
    @mesas_de_trabajo = MesaDeTrabajo.all
    @prioridad_maxima = @mesas_de_trabajo.count
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /participantes_mesas
  # POST /participantes_mesas.json
  def crear
    @mesas_de_trabajo = MesaDeTrabajo.all
    @participante = Participante.find_by_cedula(params[:cedula])
    
    @mesas_de_trabajo.each do |mesa|
      if params.has_key?("#{mesa.id}") && params["#{mesa.id}"].to_i > 0
        pm = ParticipanteMesa.new
        pm.participante = @participante
        pm.mesa_de_trabajo = mesa
        pm.prioridad = params["#{mesa.id}"]
        pm.save unless ParticipanteMesa.find_by_participante_id_and_mesa_de_trabajo_id(pm.participante.id, pm.mesa_de_trabajo.id)
      end
    end
    
    @participantes_mesas = @participante.participantes_mesas
    
    respond_to do |format|
      format.html { render action: "index" }
    end
  end
  
  # DELETE /participantes_mesas/1
  # DELETE /participantes_mesas/1.json
  def destroy
    @participante_mesa = ParticipanteMesa.find(params[:id])
    @participante_mesa.destroy

    respond_to do |format|
      format.html { redirect_to participantes_mesas_url }
      format.json { head :ok }
    end
  end

  def mesasDisponibles
    MesaDeTrabajo.find( :all, :conditions => [:sorteada => false] )
  end
end
