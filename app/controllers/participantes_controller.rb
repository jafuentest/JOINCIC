class ParticipantesController < ApplicationController
  def getParticipantes
    Participante.find( :all, :conditions => { :eliminado => false }, :order => "created_at DESC" )
  end
  
  def buscarParticipantes(nombre)
    Participante.find( :all, :conditions => ["nombre like ? OR seg_nombre like ? OR apellido like ? OR seg_apellido like ?", nombre, nombre, nombre, nombre] )
  end
  
  def zonasDisponibles
    zonas = Zona.all
    zonas.each do |z|
      if z.capacidad <= z.participantes.count
        zonas.delete(z)
      end
    end
  end
  
  def zonasDisponibles_Edit(zona)
    zonas = Zona.all
    zonas.each do |z|
      if z.capacidad <= z.participantes.count && z != zona
		    zonas.delete(z)
      end
    end
  end
  
  def reiniciarComidas
    getParticipantes.each do |p|
      p.update_attribute(:comida, false)
    end
    respond_to do |format|
      format.html { redirect_to comidas_participantes_path, notice: "El control de comidas ha sido reiniciado con éxito." }
      format.json { head :ok }
    end
  end
  
  # POST /participantes/comidas
  # POST /participantes/comidas.json
  def comidas
    if params.has_key?(:cedula)
      @participante = Participante.find_by_cedula(params[:cedula])
      if @participante.nil?
        mensaje = "No se encontró ningún participante cuya cédula sea:<br/>".html_safe + params[:cedula]
      else
        if @participante.eliminado
          mensaje = "Error: El participante fue eliminado del sistema"
        else
          if @participante.comida
            mensaje = "Ya comió"
          else
            @participante.update_attribute(:comida, true)
            mensaje = "Marcado"
          end
        end
      end
      respond_to do |format|
        format.html { redirect_to comidas_participantes_path, notice: mensaje }
        format.json { head :ok }
      end
    end    
  end
  
  # GET /participantes/buscar/1
  # GET /participantes/buscar/1.json
  def buscar
    if params.has_key?(:query) && params[:query] != ""
      if params[:query] =~ /^[0-9]+$/
        @participante = Participante.find_by_cedula(params[:query])
        
        if @participante.nil?
          flash[:notice] = "No se encontró ningún participante cuya cédula sea: " + params[:query]
          @encabezado = "Lista de participantes (" + @participantes.size.to_s + ")" unless @participantes.nil?
          @participantes = getParticipantes
        else
          redirect_to @participante
        end
      
      else
        nombre = "%"+ params[:query] +"%"
        @encabezado = "Búsqueda: " + params[:query]
        @participantes = buscarParticipantes(nombre)
        
        if @participantes.size == 0
          flash[:notice] = "No se encontró ningún particpante cuyo nombre o apellido contenga " + params[:query]
          @participantes = getParticipantes
        else
          flash[:notice] = "Error: Búsqueda vacía"
        end
      end
      
    else
      flash[:notice] = "Tienes que escribir algo si quieres hacer una busqueda..."
      @participantes = getParticipantes
      @encabezado = "Lista de participantes (" + @participantes.size.to_s + ")"
    end
    
    if @participante.nil?
      respond_to do |format|
        format.html { render action: "index" }
      end
    end
  end
  
  # GET /participantes
  # GET /participantes.json
  def index
    @participantes = getParticipantes
    @encabezado = "Lista de participantes (" + @participantes.size.to_s + ")"
    flash[:notice] = ""
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participantes }
    end
  end

  # GET /participantes/1
  # GET /participantes/1.json
  def show
    @participante = Participante.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participante }
    end
  end
  
  # GET /participantes/new
  # GET /participantes/new.json
  def new
    @participante = Participante.new
    @zonas = zonasDisponibles
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participante }
    end
  end

  # GET /participantes/1/edit
  def edit
    @participante = Participante.find(params[:id])
    @zonas = zonasDisponibles_Edit(@participante.zona)
  end
  
  # POST /participantes
  # POST /participantes.json
  def create
    @participante = Participante.new(params[:participante])
    @zonas = zonasDisponibles
    respond_to do |format|
      if @participante.save
        format.html { redirect_to @participante, notice: "El participante fue registrado con éxito" }
        format.json { render json: @participante, status: :created, location: @participante }
      else
        format.html { render action: "new" }
        format.json { render json: @participante.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /participantes/1
  # PUT /participantes/1.json
  def update
    @participante = Participante.find(params[:id])
    @zonas = zonasDisponibles_Edit(@participante.zona)
    respond_to do |format|
      if @participante.update_attributes(params[:participante])
        format.html { redirect_to @participante, notice: "El participante fue modificado con éxito" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @participante.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /participantes/1
  # DELETE /participantes/1.json
  def destroy
    Participante.find(params[:id]).update_attribute(:eliminado, true)
    Participante.find(params[:id]).update_attribute(:comida, true)
    respond_to do |format|
      format.html { redirect_to participantes_url }
      format.json { head :ok }
    end
  end
end