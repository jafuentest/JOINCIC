class ParticipantesMesasController < ApplicationController
  # GET /participantes_mesas
  # GET /participantes_mesas.json
  def index
    @participantes_mesas = ParticipanteMesa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participantes_mesas }
    end
  end

  # GET /participantes_mesas/1
  # GET /participantes_mesas/1.json
  def show
    @participante_mesa = ParticipanteMesa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participante_mesa }
    end
  end

  # GET /participantes_mesas/new
  # GET /participantes_mesas/new.json
  def new
    @participante_mesa = ParticipanteMesa.new
		@mesas = MesaDeTrabajo.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participante_mesa }
    end
  end

  # GET /participantes_mesas/1/edit
  def edit
    @participante_mesa = ParticipanteMesa.find(params[:id])
		@mesas = MesaDeTrabajo.all
  end

  # POST /participantes_mesas
  # POST /participantes_mesas.json
  def create
    @participante_mesa = ParticipanteMesa.new(params[:participante_mesa])
		@mesas = MesaDeTrabajo.all
		participante = Participante.find_by_ci_par(@participante_mesa.id_par)
		
		unless participante.nil?
		  @participante_mesa.id_par = participante.id
		end
		
		respond_to do |format|
			if (!participante.nil? && @participante_mesa.save)
				format.html { redirect_to @participante_mesa, notice: 'Participante mesa was successfully created.' }
				format.json { render json: @participante_mesa, status: :created, location: @participante_mesa }
			else
				format.html { render action: "new" }
				format.json { render json: @participante_mesa.errors, status: :unprocessable_entity }
			end
		end
  end

  # PUT /participantes_mesas/1
  # PUT /participantes_mesas/1.json
  def update
    @participante_mesa = ParticipanteMesa.find(params[:id])

    respond_to do |format|
      if @participante_mesa.update_attributes(params[:participante_mesa])
        format.html { redirect_to @participante_mesa, notice: 'Participante mesa was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @participante_mesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participantes_mesas/1
  # DELETE /participantes_mesas/1.json
  def destroy
    @participante_mesa = ParticipanteMesa.find(params[:id])
    @participante_mesa.destroy

    respond_to do |format|
      format.html { redirect_to participantes_mesas_url }
      format.json { head :ok }
    end
  end
end
