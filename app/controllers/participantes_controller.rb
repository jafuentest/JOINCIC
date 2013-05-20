class ParticipantesController < ApplicationController
  skip_before_filter :estarLogueado, :only => [:edit, :update, :show, :enviarCorreo]
  layout "application", :except => [:excel, :excelPatrocinantes]
  helper_method :sort_column, :sort_direction
  
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
  
  # GET /participantes/enviarHashAll
  # GET /participantes/enviarHashAll.json
  def enviarHashAll
	str="<hr/>"
	participantes = getParticipantesFull
    participantes.each do |p|
	  str+=p.nombreCompleto
	  str+=" <br/> "
      UserMailer.enviarHash(p).deliver
    end
    render :text => str
  end 
  
  def enviarCorreo
    if params.has_key?(:cedula)
      numero_regex = /^[0-9]+$/
      if params[:cedula] =~ numero_regex    
        @participante = Participante.find_by_cedula(params[:cedula])
        if @participante.nil?
          flash[:notice] = "No se encontró ningún participante cuya cédula sea:<br/>" + params[:cedula]
        else
          if @participante.eliminado
            flash[:notice] = "Error: El participante fue eliminado del sistema"
          else
            flash[:notice] = "Correo enviado"
            UserMailer.enviarHash(@participante).deliver
          end
        end
      else
        flash[:notice] = "Error: Número de cédula inválido"
      end
    else
      flash[:notice] = "Ingresa el número de cédula del participante"
    end
    
    respond_to do |format|
      format.html # entregarComida.html.erb
    end
  end
  
  # GET /participantes/universidades
  # GET /participantes/universidades.json
  def universidades
    unis = []
    instituciones = Participante.find(:all, :group => :institucion)
    instituciones.each do |ins|
      participantes = Participante.count(:all, :conditions => { :institucion => ins.institucion } )
      unis << { :nombre => ins.institucion, :participantes => participantes }
    end
    @universidades = unis.sort_by { |h| h[:participantes] }.reverse!
  end
  
  # GET /participantes/controlDeVentas
  # GET /participantes/controlDeVentas.json
  def controlDeVentas
    @participantes = Participante.count
    @fechas = []
    dias = Participante.group("date(convert_tz(created_at,'+0:00','-4:30'))")
    dias.each do |d|
      fecha = d.created_at.to_date
      dia = { :fecha => fecha.strftime("%b - %d") }
      ventasDelDia = Participante.find(:all, :conditions => ["date(convert_tz(created_at,'+0:00','-4:30')) >= ? AND date(convert_tz(created_at,'+0:00','-4:30')) <= ?", fecha, fecha])
        dia[:UCAB]   = ventasDelDia.count{ |p| p.organizador.institucion == "UCAB" }
        dia[:UCV]    = ventasDelDia.count{ |p| p.organizador.institucion == "UCV" }
        dia[:UNEFA]  = ventasDelDia.count{ |p| p.organizador.institucion == "UNEFA" }
        dia[:USB]    = ventasDelDia.count{ |p| p.organizador.institucion == "USB" }
      @fechas << dia
    end
    entradasVendidas  = Participante.find(:all, :conditions => ["date(convert_tz(created_at,'+0:00','-4:30')) <= ?", "2013-05-17"])
    @totalPreventa = 0
    @unisPreventa = [ { :nombre => "UCAB" }, { :nombre => "UCV" }, { :nombre => "UNEFA" }, { :nombre => "USB" } ]
    @unisPreventa.each do |u|
      entradasPorUni = entradasVendidas.count{ |p| p.organizador.institucion == u[:nombre] }
      u[:totalEntradas] = entradasPorUni
      u[:totalIngreso]  = entradasPorUni * 250
      @totalPreventa = @totalPreventa + u[:totalIngreso]
    end
    entradasVendidas  = Participante.find(:all, :conditions => ["date(convert_tz(created_at,'+0:00','-4:30')) > ?", "2013-05-17"])
    @unisVenta = [ { :nombre => "UCAB" }, { :nombre => "UCV" }, { :nombre => "UNEFA" }, { :nombre => "USB" } ]
    @unisVenta.each do |u|
      entradasPorUni = entradasVendidas.count{ |p| p.organizador.institucion == u[:nombre] }
      u[:totalEntradas] = entradasPorUni
      u[:totalIngreso]  = entradasPorUni * 300
      @totalVentaReg = u[:totalIngreso]  = entradasPorUni * 300
    end
  end
  
  # GET /participantes/reiniciarComidas
  # GET /participantes/reiniciarComidas.json
  def reiniciarComidas
    Participante.find(:all, :conditions => { :comida => true }).each do |p|
      p.update_attribute(:comida, false)
    end
    respond_to do |format|
      format.html { redirect_to entregarComida_participantes_path, notice =>  "El control de comidas ha sido reiniciado con éxito." }
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
          flash[:notice] = "No se encontró ningún participante cuya cédula sea:<br/>" + params[:cedula]
        else
          if @participante.eliminado
            flash[:notice] = "Error: El participante fue eliminado del sistema"
          else
            
            if @participante.comida
              flash[:notice] = "Ya comió"
            else
              @participante.update_attribute(:comida, true)
              flash[:notice] = "Marcado"
            end
          end
        end
      else
        flash[:notice] = "Error: Número de cédula inválido"
      end
    else
      flash[:notice] = "Ingresa el número de cédula del participante"
    end
    
    respond_to do |format|
      format.html # entregarComida.html.erb
    end
  end
  
  # GET /participantes/comidas
  def infoComidas
    @participantes = Participante.all.count
    @entregadas = Participante.find(:all, :conditions => { :comida => true }).count
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
          flash[:notice] = "No se encontró ningún participante cuya cédula sea: " + params[:query]
          @titulo = "Lista de participantes"
          @participantes = getParticipantes
        else
          redirect_to @participante
        end
      
      else
        nombre = "%"+ params[:query] +"%"
        @titulo = "Búsqueda =>  " + params[:query]
        @participantes = buscarParticipantes(nombre)
        flash[:notice] = ""
        
        if @participantes.size == 0
          flash[:notice] = "No se encontró ningún particpante cuyo nombre o apellido contenga " + params[:query]
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
    @hash = params[:hash]
    hashCorrecto = Digest::SHA1.hexdigest(params[:id].to_s + SALT)
    if !session[:organizador].nil? || !@hash.nil? && @hash == hashCorrecto
      @participante = Participante.find(params[:id])
      
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json =>  @participante }
      end
    else
      flash[:notice] = "Debe iniciar sesión para poder acceder al sistema"
      redirect_to new_session_path
    end
  end
  
  # GET /participantes/new
  # GET /participantes/new.json
  def new
    @participante = Participante.new
    @zonas = getZonasDisponibles
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json =>  @participante }
    end
  end

  # GET /participantes/1/edit
  def edit
    @hash = params[:hash]
    hashCorrecto = Digest::SHA1.hexdigest(params[:id].to_s + SALT)
    if !session[:organizador].nil? || !@hash.nil? && @hash == hashCorrecto
      @participante = Participante.find(params[:id])
      @zonas = getZonasDisponibles_Edit(@participante.zona)
    else
      flash[:notice] = "Debe iniciar sesión para poder acceder al sistema"
      redirect_to new_session_path
    end
  end
  
  # POST /participantes
  # POST /participantes.json
  def create
    @participante = Participante.new(params[:participante])
    @participante[:organizador_id] = session[:id]
    @zonas = getZonasDisponibles
    respond_to do |format|
      if @participante.save
        UserMailer.enviarHash(@participante).deliver
        format.html { redirect_to @participante, notice => "El participante fue registrado con éxito" }
        format.json { render json =>  @participante, status => :created, location => @participante }
      else
        format.html { render "new.html.erb" }
        format.json { render json => @participante.errors, status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /participantes/1
  # PUT /participantes/1.json
  def update
    @hash = params[:participante][:hash]
    hashCorrecto = Digest::SHA1.hexdigest(params[:id].to_s + SALT)
    if !session[:organizador].nil? || !@hash.nil? && @hash == hashCorrecto
      logger.warn "Intentando editar participante, id:#{params[:id]}"
      logger.warn "Organizador responsable:#{session[:organizador]}" unless session[:organizador].nil?
      logger.warn "-------------------------------"
      logger.warn "Datos de la peticion:"
      params[:participante].map.each do |k,v|
        logger.warn "#{k} => #{v}"
    end
      @participante = Participante.find(params[:id])
      @zonas = getZonasDisponibles_Edit(@participante.zona)
      logger.warn "-------------------------------"
      logger.warn "Datos previos del participante:"
      @participante.attributes.keys.each do |k|
        logger.warn "#{k} => #{@participante[k]}"
      end
      
      if session[:organizador].nil?
        params[:participante].tap { |h| h.delete(:hash) }
      end
      
      respond_to do |format|
        update = @participante.update_attributes(params[:participante])
        logger.warn "Resultado del update: #{update}"
        if update
          flash[:notice] = 'Sus datos fueron modificados con éxito'
          format.html { redirect_to :controller => 'participantes', :action => 'show', :id => params[:id], :hash => @hash }
          format.json { head :ok }
        else
          # @errors = obtener_errores(@participante)
          flash[:notice] = 'Hubo ' + @participante.errors.count.to_s + ' error(es), por favor verifique la información ingresada'
          format.html { redirect_to :controller => 'participantes', :action => 'edit', :id => params[:id], :hash => @hash }
          format.json { render json =>  @participante.errors, status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "Debe iniciar sesión para poder acceder al sistema"
      redirect_to new_session_path
    end
  end
  
  # DELETE /participantes/1
  # DELETE /participantes/1.json
  def destroy
    Participante.find(params[:id]).update_attribute(:eliminado, true)
	logger.warn "#{session[:organizador]} eliminó al participante de id: #{params[:id]}"
    respond_to do |format|
      format.html { redirect_to participantes_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def getParticipantes
    Participante.order(sort_column + " " + sort_direction).paginate :per_page => 20, :page => params[:page], :conditions => { :eliminado => nil }
  end
  
  def getParticipantesFiltrar(tipo, param)
    Participante.order(sort_column + " " + sort_direction).paginate :per_page => 20, :page => params[:page], :conditions => { tipo.to_sym => param }
  end
  
  def getParticipantesFull
    Participante.find :all, :order => "created_at DESC", :conditions => { :eliminado => nil }
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
  
  def getZonasDisponibles
    zonas = Zona.all
    zonasDisponibles = []
    
    zonas.each do |z|
      if z.capacidad > z.participantes.count
        zonasDisponibles << z
      end
    end
    
    zonasDisponibles
  end
  
  def getZonasDisponibles_Edit(zona)
    zonas = Zona.all
    zonasDisponibles = []
    
    zonas.each do |z|
      if (z.capacidad > z.participantes.count) || (z == zona)
        zonasDisponibles << z
      end
    end
    
    zonasDisponibles
  end
end
