class ParticipantesController < ApplicationController
  require 'json'

  skip_before_filter :organizadorLogin, only: [:edit, :update, :show, :enviarCorreo, :validarCedula]

  layout 'application', except: [:excel, :excelPatrocinantes]

  helper_method :sort_column, :sort_direction

  # GET /participantes/validarCedula.json?cedula=1
  def validarCedula
    @participante = Participante.find_by_cedula(params[:cedula])
    respond_to do |format|
      if @participante.nil?
        format.json { head :not_found }
      else
        format.json { render json: @participante }
      end
    end
  end

  def excel
    headers['Content-Type'] = 'application/vnd.ms-excel'
    headers['Content-Disposition'] = 'attachment; filename="participantes.xls"'
    headers['Cache-Control'] = ''
    @participantes = getParticipantesFull
  end

  def excelPatrocinantes
    headers['Content-Type'] = 'application/vnd.ms-excel'
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
  def enviarCorreoATodos
    str='<hr/>'
    participantes = getParticipantesFull
    participantes.each do |p|
      str+=p.nombreCompleto
      str+='<br/>'
      UserMailer.enviarHash(p).deliver
    end
    render text: str
  end

  def enviarCorreo
    if params.has_key?(:cedula)
      numero_regex = /^[0-9]+$/
      if params[:cedula] =~ numero_regex
        @participante = Participante.find_by_cedula(params[:cedula])
        if @participante.nil?
          flash[:notice] = 'No se encontró ningún participante cuya cédula sea:<br/>'.html_safe + params[:cedula]
        else
          if @participante.eliminado
            flash[:notice] = 'Error: El participante fue eliminado del sistema'
          else
            flash[:notice] = 'Correo enviado'
            UserMailer.enviarHash(@participante).deliver
          end
        end
      else
        flash[:notice] = 'Error: Número de cédula inválido'
      end
    else
      flash[:notice] = 'Ingresa el número de cédula del participante'
    end

    respond_to do |format|
      format.html # entregarComida.html.erb
    end
  end

  # GET /participantes/universidades
  # GET /participantes/universidades.json
  def universidades
    unis = []
    instituciones = Participante.find(:all, group: :institucion)
    instituciones.each do |ins|
      participantes = Participante.count(:all, conditions: { institucion: ins.institucion } )
      unis << { nombre: ins.institucion, participantes: participantes }
    end
    @universidades = unis.sort_by { |h| h[:participantes] }.reverse!
  end

  # GET /participantes/controlDeVentas
  # GET /participantes/controlDeVentas.json
  def controlDeVentas
    @participantes = Participante.count
    @fechas = []
    dias = Participante.group('date(convert_tz(created_at,\'+0:00\',\'-4:30\'))')
    dias.each do |d|
      fecha = d.created_at.to_date
      dia = { fecha: fecha.strftime('%b - %d') }
      ventasDelDia = Participante.find(:all, conditions: ['date(convert_tz(created_at,\'+0:00\',\'-4:30\')) >= ? AND date(convert_tz(created_at,\'+0:00\',\'-4:30\')) <= ?', fecha, fecha])
        dia[:UCAB]   = ventasDelDia.count{ |p| p.organizador.institucion == 'UCAB'  unless p.organizador.nil? }
        dia[:UCV]    = ventasDelDia.count{ |p| p.organizador.institucion == 'UCV'   unless p.organizador.nil? }
        dia[:UNEFA]  = ventasDelDia.count{ |p| p.organizador.institucion == 'UNEFA' unless p.organizador.nil? }
        dia[:USB]    = ventasDelDia.count{ |p| p.organizador.institucion == 'USB'   unless p.organizador.nil? }
      @fechas << dia
    end
    entradasVendidas  = Participante.find(:all, conditions: ['date(convert_tz(created_at,\'+0:00\',\'-4:30\')) <= ?', '2013-05-17'])
    @totalPreventa = 0
    @unisPreventa = [ { nombre: 'UCAB' }, { nombre: 'UCV' }, { nombre: 'UNEFA' }, { nombre: 'USB' } ]
    @unisPreventa.each do |u|
      entradasPorUni = entradasVendidas.count{ |p| p.organizador.institucion == u[:nombre] }
      u[:totalEntradas] = entradasPorUni
      u[:totalIngreso]  = entradasPorUni * 250
      @totalPreventa = @totalPreventa + u[:totalIngreso]
    end
    entradasVendidas  = Participante.find(:all, conditions: ['date(convert_tz(created_at,\'+0:00\',\'-4:30\')) > ?', '2013-05-17'])
    @unisVenta = [ { nombre: 'UCAB' }, { nombre: 'UCV' }, { nombre: 'UNEFA' }, { nombre: 'USB' } ]
    @unisVenta.each do |u|
      entradasPorUni = entradasVendidas.count{ |p| p.organizador.institucion == u[:nombre] unless p.organizador.nil?}
      u[:totalEntradas] = entradasPorUni
      u[:totalIngreso]  = entradasPorUni * 300
      @totalVentaReg = u[:totalIngreso]  = entradasPorUni * 300
    end
  end

  # GET /participantes/reiniciarComidas
  # GET /participantes/reiniciarComidas.json
  def reiniciarComidas
    Participante.find(:all, conditions: { comida: true }).each do |p|
      p.update_attribute(:comida, false)
    end
    respond_to do |format|
      format.html { redirect_to entregarComida_participantes_path, notice:  'El control de comidas ha sido reiniciado con éxito.' }
      format.json { head :ok }
    end
  end

  # POST /participantes/1/entregarComida
  # POST /participantes/1/entregarComida.json
  def entregarComida
    if params.has_key?(:entrada)

      numero_regex = /^[0-9]+$/

      if params[:entrada] =~ numero_regex
        @participante = Participante.find_by_entrada(params[:entrada])

        if @participante.nil?
          flash[:notice] = "No se encontró ningún participante con la entrada:<br/> #{params[:entrada]}".html_safe
        else
          if @participante.eliminado
            flash[:notice] = 'Error: El participante fue eliminado del sistema'
          else

            if @participante.comida
              flash[:notice] = 'Ya comió'
            else
              @participante.update_attribute(:comida, true)
              flash[:notice] = 'Marcado'
            end
          end
        end
      else
        flash[:notice] = 'Error: Número de entrada inválido'
      end
    else
      flash[:notice] = 'Ingresa el número de entrada del participante'
    end

    respond_to do |format|
      format.html # entregarComida.html.erb
    end
  end

  # GET /participantes/comidas
  def infoComidas
    @participantes = Participante.all.count
    @entregadas = Participante.find(:all, conditions: { comida: true }).count
    @por_entregar = @participantes - @entregadas
    respond_to do |format|
      format.html # comidas.html.erb
    end
  end

  # GET /participantes/buscar/1
  # GET /participantes/buscar/1.json
  def buscar
    if params.has_key?(:query) && params[:query] != ''
      if params[:query] =~ /^[0-9]+$/
        @participante = Participante.find_by_cedula(params[:query])
        if @participante.nil?
          flash[:notice] = "No se encontró ningún participante cuya cédula sea: #{params[:query]}"
          @titulo = 'Lista de participantes'
          @participantes = getParticipantes
        else
          redirect_to @participante
        end

      else
        nombre = "%#{params[:query]}%"
        @titulo = 'Búsqueda => ' + params[:query]
        @participantes = buscarParticipantes(nombre)
        flash[:notice] = ''

        if @participantes.size == 0
          flash[:notice] = 'No se encontró ningún particpante cuyo nombre o apellido contenga ' + params[:query]
          @participantes = getParticipantes
          @titulo = 'Lista de participantes'
        end
      end

    else
      flash[:notice] = 'Tienes que escribir algo si quieres hacer una busqueda...'
      @participantes = getParticipantes
      @titulo = 'Lista de participantes'
    end

    if @participante.nil?
      respond_to do |format|
        format.html { render 'index.html.erb' }
      end
    end
  end

  # GET /participantes
  # GET /participantes.json
  def index
    if params.has_key?(:uni) && params[:uni] != ''
      @titulo = 'Lista de participantes ' + params[:uni]
      @participantes = getParticipantesFiltrarUni params[:uni]
    else
      @titulo = 'Lista de participantes'
      @participantes = getParticipantes
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participantes }
    end
  end

  # GET /participantes/1
  # GET /participantes/1.json
  def show
    @hash = params[:hash]
    hashCorrecto = Digest::SHA1.hexdigest(params[:id].to_s + SALT)
    if session[:organizador].nil? && (@hash.nil? || @hash != hashCorrecto)
      flash[:notice] = 'Debe iniciar sesión para poder acceder al sistema'
      redirect_to new_session_path
    else
      @participante = Participante.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @participante }
      end
    end
  end

  # GET /participantes/new
  # GET /participantes/new.json
  def new
    @participante = Participante.new
    @zonas = getZonasDisponibles
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /participantes/1/edit
  def edit
    @hash = params[:hash]
    hashCorrecto = Digest::SHA1.hexdigest(params[:id].to_s + SALT)
    if session[:organizador].nil?  && (@hash.nil? || @hash != hashCorrecto)
      flash[:notice] = 'Debe iniciar sesión para poder acceder al sistema'
      redirect_to new_session_path
    else
      @participante = Participante.find(params[:id])
      unless session[:organizador].nil?
        @zonas = getZonasDisponiblesEdit(@participante.zona)
      end
    end
  end

  # POST /participantes
  # POST /participantes.json
  def create
    @participante = Participante.new(participante_params)
    @participante[:organizador_id] = session[:usuario_id]
    @zonas = getZonasDisponibles
    respond_to do |format|
      if @participante.save
        # UserMailer.enviarHash(@participante).deliver
        format.html { redirect_to @participante, notice: 'El participante fue registrado con éxito' }
        format.json { render json: @participante, status: :created, location: @participante }
      else
        format.html { render 'new.html.erb' }
        format.json { render json: @participante.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participantes/1
  # PUT /participantes/1.json
  def update
    @hash = params[:participante][:hash]
    hashCorrecto = Digest::SHA1.hexdigest(params[:id].to_s + SALT)

    if session[:organizador].nil?  && (@hash.nil? || @hash != hashCorrecto)
      flash[:notice] = 'Debe iniciar sesión para poder acceder al sistema'
      redirect_to new_session_path
    else
      #BEGIN Registro de los datos de la petición y el responsable
      logger.warn "Modificacion sobre el participante: #{params[:id]}"
      registro = ''
      registro += "Organizador responsable:#{session[:organizador]}\n" unless session[:organizador].nil?
      registro += "-------------------------------\n"
      registro += "Datos de la peticion:\n"
      parametrosActualizados = ""
      params[:participante].map.each do |k,v|
        parametrosActualizados += "#{k}: #{v} - "
      end
      registro += parametrosActualizados + "\n"
      #END

      @participante = Participante.find(params[:id])
      @zonas = getZonasDisponiblesEdit @participante.zona

      #BEGIN Respaldo de los datos anteriores del participante
      registro += "-------------------------------\n"
      registro += "Datos previos:\n"
      parametrosOriginales = ''
      @participante.attributes.keys.each do |k|
        parametrosOriginales += "#{k}: #{@participante[k]} - "
      end
      registro += parametrosOriginales + "\n"
      #END

      unless params[:participante][:hash].nil?
        params[:participante].tap { |h| h.delete(:hash) }
      end

      respond_to do |format|
        if @participante.update_attributes(participante_params)
          logger.warn registro
          flash[:notice] = 'Sus datos fueron modificados con éxito'
          format.html { redirect_to controller: 'participantes', action: 'show', id: params[:id], hash: @hash }
          format.json { head :ok }
        else
          if session[:organizador].nil?
            logger.warn 'Fail (Participante)'
          else
            logger.warn "Fail (Organizador: #{session[:organizador]})"
          end
          format.html { render 'edit.html.erb' }
          format.json { render json: @participante.errors, status: :unprocessable_entity }
        end
      end
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
    Participante.where(eliminado: 0).order("#{sort_column} #{sort_direction}").paginate(per_page: 20, page: params[:page])
  end

  def getParticipantesFiltrarUni(uni)
    Participante.where(institucion: uni).order("#{sort_column} #{sort_direction}").paginate(per_page: 20, page: params[:page])
  end

  def getParticipantesFull
    Participante.where(eliminado: 0).order('created_at DESC')
  end

  def buscarParticipantes(nombre)
    Participante.where(['nombre like ? OR seg_nombre like ? OR apellido like ? OR seg_apellido like ?', nombre, nombre, nombre, nombre]).order(sort_column + ' ' + sort_direction).paginate(per_page: 20, page: params[:page])
  end

  def sort_column
    Participante.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def getZonasDisponibles
    zonas = Zona.all
    zonasDisponibles = []

    zonas.each do |z|
      zonasDisponibles << z if z.capacidad > z.participantes.count
    end

    zonasDisponibles
  end

  def getZonasDisponiblesEdit(zona)
    zonas = Zona.all
    zonasDisponibles = []

    zonas.each do |z|
      zonasDisponibles << z if (z.capacidad > z.participantes.count) || (z == zona)
    end

    zonasDisponibles
  end

  private

  def participante_params
    params.require(:participante).permit(:cedula, :nombre, :seg_nombre, :apellido, :seg_apellido,
      :fecha_nac, :direccion, :correo, :telefono, :institucion, :carrera, :nivel, :tipo_nivel,
      :zona_id, :entrada, :deposito, :esEstudiante
    )
  end
end
