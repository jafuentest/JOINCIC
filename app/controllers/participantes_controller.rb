class ParticipantesController < ApplicationController
  layout "application", :except => [:excel, :excelPatrocinantes]
  helper_method :sort_column, :sort_direction

  def universidades
    unis = []
    instituciones = Participante.find(:all, :group => :institucion)
    instituciones.each do |ins|
	  participantes = Participante.count(:all, :conditions => { :institucion => ins.institucion } )
	  unis << { :nombre => ins.institucion, :participantes => participantes }
    end
    @universidades = unis.sort_by { |h| h[:participantes] }.reverse!
  end
  
  def reiniciarComidas
    Participante.find (:all, :conditions => { :comida => true }).each do |p|
      p.update_attribute(:comida, false)
    end
    respond_to do |format|
      format.html { redirect_to entregarComida_participantes_path, notice =>  "El control de comidas ha sido reiniciado con &eacute;xito.".html_safe }
      format.json { head :ok }
    end
  end
  
  # POST /participantes/1/entregarComida
  # POST /participantes/1/entregarComida.json
  def entregarComida
    if params.has_key?(:cedula)
    
      numero_regex = /^[0-9]+$/
      
      if params[:cedula] =~ numero_regex    
        @participante = Participante.find_by_cedula(params[:cedula])
        
        if @participante.nil?
          flash[:notice] = "No se encontr&oacute; ning&uacute;n participante cuya c&eacute;dula sea:<br/>".html_safe + params[:cedula]
        else
          if @participante.eliminado
            flash[:notice] = "Error: El participante fue eliminado del sistema"
          else
            
            if @participante.comida
              flash[:notice] = "Ya comi&oacute;".html_safe
            else
              @participante.update_attribute(:comida, true)
              flash[:notice] = "Marcado"
            end
          end
        end
      else
        flash[:notice] = "Error: N&uacute;mero de c&eacute;dula inv&aacute;lido".html_safe
      end
    else
      flash[:notice] = "Ingresa el n&uacute;mero de c&eacute;dula del participante".html_safe
    end
    
    respond_to do |format|
      format.html # entregarComida.html.erb
    end
  end
  
  # GET /participantes/comidas
  def infoComidas
    @participantes = Participante.all.count
    @entregadas = Participante.find (:all, :conditions => { :comida => true }).count
    @por_entregar = @participantes - @entregadas
    
    respond_to do |format|
      format.html # comidas.html.erb
    end
  end
  
  # GET /participantes/buscar/1
  # GET /participantes/buscar/1.json
  def buscar
    if params.has_key?(:query) && params[:query] != ""
      if params[:query] =~ /^[0-9]+$/
        @participante = Participante.find_by_cedula(params[:query])
        
        if @participante.nil?
          flash[:notice] = "No se encontr&oacute; ning&uacute;n participante cuya c&eacute;dula sea: ".html_safe + params[:query]
          @titulo = "Lista de participantes"
          @participantes = getParticipantes
        else
          redirect_to @participante
        end
      
      else
        nombre = "%"+ params[:query] +"%"
        @titulo = "B&uacute;squeda =>  ".html_safe + params[:query]
        @participantes = buscarParticipantes(nombre)
        flash[:notice] = ""
        
        if @participantes.size == 0
          flash[:notice] = "No se encontr&oacute; ning&uacute;n particpante cuyo nombre o apellido contenga ".html_safe + params[:query]
          @participantes = getParticipantes
          @titulo = "Lista de participantes"
        end
      end
      
    else
      flash[:notice] = "Tienes que escribir algo si quieres hacer una busqueda..."
      @participantes = getParticipantes
      @titulo = "Lista de participantes"
    end
    
    if @participante.nil?
      respond_to do |format|
        format.html { render "index.html.erb" }
      end
    end
  end
  
  # GET /participantes
  # GET /participantes.json
  def index
    if params.has_key?(:uni) && params[:uni] != ""
      @titulo = "Listda de estudiantes " + params[:uni]
      @participantes = getParticipantesFiltrar("institucion", params[:uni])
    else
      @titulo = "Lista de participantes"
      @participantes = getParticipantes
    end
    flash[:notice] = ""
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json =>  @participantes }
    end
  end

  # GET /participantes/1
  # GET /participantes/1.json
  def show
    @participante = Participante.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json =>  @participante }
    end
  end
  
  # GET /participantes/new
  # GET /participantes/new.json
  def new
    @participante = Participante.new
    @zonas = zonasDisponibles
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json =>  @participante }
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
        format.html { redirect_to @participante, notice =>  "El participante fue registrado con &eacute;xito".html_safe }
        format.json { render json =>  @participante, status =>  :created, location =>  @participante }
      else
        format.html { render "new.html.erb" }
        format.json { render json =>  @participante.errors, status =>  :unprocessable_entity }
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
        format.html { redirect_to @participante, notice =>  "El participante fue modificado con &eacute;xito".html_safe }
        format.json { head :ok }
      else
        format.html { render "edit.html.erb" }
        format.json { render json =>  @participante.errors, status =>  :unprocessable_entity }
      end
    end
  end
  
  # DELETE /participantes/1
  # DELETE /participantes/1.json
  def destroy
    Participante.find(params[:id]).update_attribute(:eliminado, true)
    respond_to do |format|
      format.html { redirect_to participantes_url }
      format.json { head :ok }
    end
  end
  
  def excel
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="participantes.xls"'
    headers['Cache-Control'] = ''
    @participantes = getParticipantesFull
  end
  
  def excelPatrocinantes
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="participantes.xls"'
    headers['Cache-Control'] = ''
    @participantes = getParticipantesFull
  end
  
  def xml
	@participantes = getParticipantesFull
	
	respond_to do |format|
	  format.xml # participantesRifas.xml.builder
	end
  end
  
  private
  
  def getParticipantes
    Participante.order(sort_column + " " + sort_direction).paginate :per_page => 20, :page => params[:page]
  end
  
  def getParticipantesFiltrar(tipo, param)
    Participante.order(sort_column + " " + sort_direction).paginate :per_page => 20, :page => params[:page], :conditions => { tipo.to_sym => param }
  end
  
  def getParticipantesFull
	Participante.find :all, :order => "cedula", :conditions => { :eliminado => false }
  end
  
  def buscarParticipantes(nombre)
    Participante.order(sort_column + " " + sort_direction).paginate :per_page => 20, :page => params[:page], :conditions => ["nombre like ? OR seg_nombre like ? OR apellido like ? OR seg_apellido like ?", nombre, nombre, nombre, nombre]
  end
  
  def sort_column
    Participante.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
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
end
