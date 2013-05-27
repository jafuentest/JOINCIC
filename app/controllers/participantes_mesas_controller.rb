class ParticipantesMesasController < ApplicationController
  # GET /participantes_mesas/new
  # GET /participantes_mesas/new.json
  def new
    numero_regex = /^[0-9]+$/
    
    if params.has_key?(:cedula) && params[:cedula] != ""
      if params[:cedula] =~ numero_regex
        @participante = Participante.find_by_cedula(params[:cedula])
        if @participante.nil?
          flash[:notice] = "No se encontró ningún participante cuya cédula sea: <br/>".html_safe + params[:cedula]
          redirect_to buscar_participantes_mesas_path
        elsif @participante.eliminado
          flash[:notice] = "Error: El participante fue eliminado del sistema"
          redirect_to buscar_participantes_mesas_path
        else
          @participantes_mesas = @participante.participantes_mesas
          respond_to do |format|
            if @participantes_mesas.size > 0
              format.html { render "edit.html.erb" }
            else
              @mesas_de_trabajo = MesaDeTrabajo.find(:all, :conditions => {:dia => Time.now.strftime("%Y-%m-%d")})
              @prioridad_maxima = @mesas_de_trabajo.size
              format.html { render "new.html.erb" }
            end
          end
        end
      else
        flash[:notice] = "Error: Número de cédula inválido"
        redirect_to buscar_participantes_mesas_path
      end
    else
      flash[:notice] = "Ingresa el número de cédula del participante"
      redirect_to buscar_participantes_mesas_path
    end
  end


  # POST /participantes_mesas
  # POST /participantes_mesas.json
  def create
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
      format.html { render "index.html.erb" }
    end
  end

  def mesasDisponibles
    MesaDeTrabajo.find( :all, :conditions => [:sorteada => false] )
  end
end
