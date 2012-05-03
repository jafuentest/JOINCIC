class ParticipantesMatesController < ApplicationController
  # GET /participantes_mates
  # GET /participantes_mates.json
  def index
    if params.has_key?(:cedula) && params[:cedula] != ""
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json => @participantes_mates }
      end
    else
      flash[:notice] = "Ingresa el número de cédula del participante"
      redirect_to buscar_participantes_mates_path
    end
  end
  
  # GET /participantes_mates/1
  # GET /participantes_mates/1.json
  def show
    numero_regex = /^[0-9]+$/
    
    if params[:id] =~ numero_regex
      @participante = Participante.find_by_cedula(params[:id])
      
      if @participante.nil?
        flash[:notice] = "No se encontró ningún participante cuya cédula sea: <br/>".html_safe + params[:id]
        redirect_to buscar_participantes_mates_path
      else
        @participantes_mates = @participante.participantes_mates
        
        if @participante.eliminado
          flash[:notice] = "Error: El participante fue eliminado del sistema"
          redirect_to buscar_participantes_mates_path
        else
          respond_to do |format|
            if @participantes_mates.size > 0
              format.html { render "index.html.erb" }
            else
              @materiales_pop = MaterialPop.all
              format.html { render "new.html.erb" }
            end
          end
        end
      end
    
    else
      flash[:notice] = "Error: Número de cédula inválido"
      redirect_to buscar_participantes_mates_path
    end
  end
  
  # GET /participantes_mates/new
  # GET /participantes_mates/new.json
  def new
    @participante = Participante.find_by_cedula(params[:cedula])
    @materiales_pop = MaterialPop.all
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # POST /participantes_mates
  # POST /participantes_mates.json
  def entregar
    entrega = ParticipanteMate.find_by_participante_id_and_material_pop_id(params[:participante_id], params[:material_pop_id])
    entrega.update_attribute(:entregado, true)
    
    @participante = entrega.participante
    @participantes_mates = @participante.participantes_mates
    
    respond_to do |format|
      format.html { render "index.html.erb" }
    end
  end
  
  # POST /participantes_mates
  # POST /participantes_mates.json
  def crear
    @materiales_pop = MaterialPop.all
    @participante = Participante.find_by_cedula(params[:cedula])
    
    @materiales_pop.each do |material|
      pm = ParticipanteMate.new
      pm.participante = @participante
      pm.material_pop = material
      if params.has_key?(material.nombre)
        pm.entregado = true
      else
        pm.entregado = false
      end
      
      pm.save unless ParticipanteMate.find_by_participante_id_and_material_pop_id(pm.participante.id, pm.material_pop.id)
    end
    
    @participantes_mates = @participante.participantes_mates
    
    respond_to do |format|
      format.html { render "index.html.erb" }
    end
  end
end