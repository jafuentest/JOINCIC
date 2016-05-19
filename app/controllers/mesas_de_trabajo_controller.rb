class MesasDeTrabajoController < ApplicationController
  skip_before_filter :organizadorLogin, only: [:index, :show]
  before_action :set_mesa_de_trabajo, only: [:show, :edit, :update, :destroy, :reiniciar, :sortear, :excel]

  layout false, only: [:excel]

  # POST /mesas_de_trabajo/sortear
  # POST /mesas_de_trabajo/sortear.json
  def sortear
    # Obtener la maxima cantidad de veces que un participante ha quedado
    # seleccionado en mesas de trabajo
    participantes = Participante.all
    max = 0
    participantes.each do |p|
      temp = p.participantes_mesas.count(conditions: { seleccionado: true })
      if temp > max
        max = temp
      end
    end

    participantes = []
    for i in 0..max
      temp = []
      @mesa_de_trabajo.participantes_mesas.each do |ins|
        temp << ins if ins.participante.numeroDeMesasGanadas == i
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

  # POST /mesas_de_trabajo/reiniciar
  # POST /mesas_de_trabajo/reiniciar.json
  def reiniciar
    @mesa_de_trabajo.participantes_mesas.each do |inscripcion|
      inscripcion.update_attributes(puesto: nil, seleccionado: nil)
    end
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
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
      format.json { render json: @mesas_de_trabajo.to_json(include: [:ponente]) }
    end
  end

  # GET /mesas_de_trabajo/1
  # GET /mesas_de_trabajo/1.json
  def show
    @participantes = @mesa_de_trabajo.participantes_mesas.order(:puesto)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mesa_de_trabajo.to_json(include: [:ponente]) }
    end
  end

  # GET /mesas_de_trabajo/new
  # GET /mesas_de_trabajo/new.json
  def new
    @mesa_de_trabajo = MesaDeTrabajo.new
    @patrocinantes = Patrocinante.order(:nombre)
    @ponentes = Ponente.order(:nombre)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mesa_de_trabajo }
    end
  end

  # GET /mesas_de_trabajo/1/edit
  def edit
    @patrocinantes = Patrocinante.order(:nombre)
    @ponentes = Ponente.order(:nombre)
  end

  # POST /mesas_de_trabajo
  # POST /mesas_de_trabajo.json
  def create
    @mesa_de_trabajo = MesaDeTrabajo.new(mesa_de_trabajo_params)
    respond_to do |format|
      if @mesa_de_trabajo.save
        format.html { redirect_to @mesa_de_trabajo, notice: 'Mesa de trabajo was successfully created.' }
        format.json { render json: @mesa_de_trabajo, status: :created, location: @mesa_de_trabajo }
      else
        @patrocinantes = Patrocinante.order(:nombre)
        @ponentes = Ponente.order(:nombre)
        format.html { render 'new.html.erb' }
        format.json { render json: @mesa_de_trabajo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mesas_de_trabajo/1
  # PUT /mesas_de_trabajo/1.json
  def update
    @patrocinantes = Patrocinante.order(:nombre)
    @ponentes = Ponente.order(:nombre)
    respond_to do |format|
      if @mesa_de_trabajo.update_attributes(mesa_de_trabajo_params)
        format.html { redirect_to @mesa_de_trabajo,notice: 'Mesa de Trabajo actualizada con éxito.' }
        format.json { head :ok }
      else
        format.html { render 'edit.html.erb' }
        format.json { render json: @mesa_de_trabajo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mesas_de_trabajo/1
  # DELETE /mesas_de_trabajo/1.json
  def destroy
    @mesa_de_trabajo.destroy
    respond_to do |format|
      format.html { redirect_to mesas_de_trabajo_url }
      format.json { head :ok }
    end
  end

  def excel
    headers['Content-Type'] = 'application/vnd.ms-excel'
    headers['Content-Disposition'] = 'attachment; filename="participantes.xls"'
    headers['Cache-Control'] = ''
    @participantes = @mesa_de_trabajo.participantes_mesas.order(:puesto)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def mesa_de_trabajo_params
    params.require(:mesa_de_trabajo).permit(:titulo, :tema, :descripcion, :dia, :hora_ini,
      :hora_fin, :lugar, :capacidad, :requerimientos, :sorteada, :ponente_id, :patrocinante_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_mesa_de_trabajo
    @mesa_de_trabajo = MesaDeTrabajo.find(params[:id])
  end
end
