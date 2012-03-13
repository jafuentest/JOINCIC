class MesasDeTrabajoController < ApplicationController
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
    @participantes = @mesa_de_trabajo.participantes_mesas

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
    @ponentes = Ponente.all(:order => :apellido)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mesa_de_trabajo }
    end
  end

  # GET /mesas_de_trabajo/1/edit
  def edit
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
  end

  # POST /mesas_de_trabajo
  # POST /mesas_de_trabajo.json
  def create
    @mesa_de_trabajo = MesaDeTrabajo.new(params[:mesa_de_trabajo])

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