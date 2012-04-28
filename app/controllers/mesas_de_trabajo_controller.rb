class MesasDeTrabajoController < ApplicationController
  # POST /mesas_de_trabajo
  # POST /mesas_de_trabajo.json
  def sortear
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
    
    participantes = []
    for i in 1..5
      inscripciones = ParticipanteMesa.all(:conditions => { :prioridad => i, :mesa_de_trabajo_id => @mesa_de_trabajo.id })
      temp = []
      inscripciones.shuffle.each do |ins|
        temp << ins if ins.participante.numDeMesasGanadas < 1
      end
      participantes += temp.shuffle
    end
    
    for i in 1..5
      inscripciones = ParticipanteMesa.all(:conditions => { :prioridad => i, :mesa_de_trabajo_id => @mesa_de_trabajo.id })
      temp = []
      inscripciones.shuffle.each do |ins|
        temp << ins if ins.participante.numDeMesasGanadas < 1
      end
      participantes += temp.shuffle
    end
    
    participantes.each_with_index do |p, i|
      p.update_attribute(:puesto, i+1)
      if p.puesto <= @mesa_de_trabajo.capacidad
        p.update_attribute(:seleccionado, true)
      end
    end
    
    @mesa_de_trabajo.update_attribute(:sorteada, true)
    @participantes = @mesa_de_trabajo.participantes_mesas
    redirect_to @mesa_de_trabajo
  end
  
  def reiniciar
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
    
    inscripciones = ParticipanteMesa.all(:conditions => { :mesa_de_trabajo_id => @mesa_de_trabajo.id })
    inscripciones.each do |ins|
      ins.update_attribute(:puesto, nil)
    end
    
    @mesa_de_trabajo.update_attribute(:sorteada, false)
    @participantes = @mesa_de_trabajo.participantes_mesas
    redirect_to @mesa_de_trabajo
  end
  
  # GET /mesas_de_trabajo
  # GET /mesas_de_trabajo.json
  def index
    @mesas_de_trabajo = MesaDeTrabajo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mesas_de_trabajo }
    end
  end

  # GET /mesas_de_trabajo/1
  # GET /mesas_de_trabajo/1.json
  def show
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
    @participantes = ParticipanteMesa.find(:all, :order => "puesto", :conditions => { :mesa_de_trabajo_id => params[:id] })

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mesa_de_trabajo }
    end
  end

  # GET /mesas_de_trabajo/new
  # GET /mesas_de_trabajo/new.json
  def new
    @mesa_de_trabajo = MesaDeTrabajo.new
    @patrocinantes = Patrocinante.all(:order => :nombre)
    @ponentes = Ponente.all(:order => :nombre)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mesa_de_trabajo }
    end
  end

  # GET /mesas_de_trabajo/1/edit
  def edit
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
    @patrocinantes = Patrocinante.all(:order => :nombre)
    @ponentes = Ponente.all(:order => :nombre)
  end

  # POST /mesas_de_trabajo
  # POST /mesas_de_trabajo.json
  def create
    @mesa_de_trabajo = MesaDeTrabajo.new(params[:mesa_de_trabajo])
    @patrocinantes = Patrocinante.all(:order => :nombre)
    @ponentes = Ponente.all(:order => :nombre)

    respond_to do |format|
      if @mesa_de_trabajo.save
        format.html { redirect_to @mesa_de_trabajo, notice: 'Mesa de trabajo was successfully created.' }
        format.json { render json: @mesa_de_trabajo, status: :created, location: @mesa_de_trabajo }
      else
        format.html { render action: "new" }
        format.json { render json: @mesa_de_trabajo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mesas_de_trabajo/1
  # PUT /mesas_de_trabajo/1.json
  def update
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
    @patrocinantes = Patrocinante.all(:order => :nombre)
    @ponentes = Ponente.all(:order => :nombre)

    respond_to do |format|
      if @mesa_de_trabajo.update_attributes(params[:mesa_de_trabajo])
        format.html { redirect_to @mesa_de_trabajo, notice: 'Mesa de trabajo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mesa_de_trabajo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mesas_de_trabajo/1
  # DELETE /mesas_de_trabajo/1.json
  def destroy
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
    @mesa_de_trabajo.destroy

    respond_to do |format|
      format.html { redirect_to mesas_de_trabajo_url }
      format.json { head :ok }
    end
  end
end