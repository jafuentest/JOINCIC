class ParticipantesController < ApplicationController
  
  # GET /participantes
  # GET /participantes.json
  def index
    @participantes = Participante.find( :all, :conditions => { :eliminado => false }, :order => "created_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participantes }
    end
  end
  
  # POST /participantes/buscar
  # POST /participantes/buscar.json
  def buscar
    @participante = Participante.find_by_cedula(params[:cedula])
    if @participante.nil?
      redirect_to :participantes, notice: "No se encontró ningún participante cuya cédula sea: " + params[:cedula]
    else
      redirect_to @participante
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
  
  def zonasDisponibles
    zonas = Zona.all
    zonas.each do |z|
      if z.capacidad <= z.participantes.count
        zonas.delete(z)
      end
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

  def zonasDisponibles_Edit (zona)
    zonas = Zona.all
    zonas.each do |z|
      if z.capacidad <= z.participantes.count && z != zona
		    zonas.delete(z)
      end
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
    respond_to do |format|
      format.html { redirect_to participantes_url }
      format.json { head :ok }
    end
  end
  
  # POST /participantes/comidas
  # POST /participantes/comidas.json
  def comidas
    if params.has_key?(:cedula)
      @participante = Participante.find_by_cedula(params[:cedula])
      if @participante.nil?
        mensaje = "No se encontró ningún participante cuya cédula sea: " + params[:cedula]
      else
        if @participante.comida
          mensaje = "Ya comió"
        else
          @participante.update_attribute(:comida, true)
          mensaje = "Marcado"
        end
      end
      respond_to do |format|
        format.html { redirect_to "/participantes/comidas", notice: mensaje }
        format.json { head :ok }
      end
    end    
  end
  
  def reiniciarComidas
    Participante.all.each do |p|
      p.update_attribute(:comida, false)
    end
    respond_to do |format|
      format.html { redirect_to "/participantes/comidas", notice: "El control de comidas ha sido reiniciado con éxito." }
      format.json { head :ok }
    end
  end
end