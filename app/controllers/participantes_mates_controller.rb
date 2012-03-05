class ParticipantesMatesController < ApplicationController
  # GET /participantes_mates
  # GET /participantes_mates.json
  def index
    @participantes_mates = ParticipanteMate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participantes_mates }
    end
  end

  # GET /participantes_mates/1
  # GET /participantes_mates/1.json
  def show
    @participante_mate = ParticipanteMate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participante_mate }
    end
  end

  # GET /participantes_mates/new
  # GET /participantes_mates/new.json
  def new
    @participante_mate = ParticipanteMate.new
    @materiales_pop = MaterialPop.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participante_mate }
    end
  end

  # GET /participantes_mates/1/edit
  def edit
    @participante_mate = ParticipanteMate.find(params[:id])
  end

  # POST /participantes_mates
  # POST /participantes_mates.json
  def create
    @participante_mate = ParticipanteMate.new(params[:participante_mate])

    respond_to do |format|
      if @participante_mate.save
        format.html { redirect_to @participante_mate, notice: 'Participante mate was successfully created.' }
        format.json { render json: @participante_mate, status: :created, location: @participante_mate }
      else
        format.html { render action: "new" }
        format.json { render json: @participante_mate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participantes_mates/1
  # PUT /participantes_mates/1.json
  def update
    @participante_mate = ParticipanteMate.find(params[:id])

    respond_to do |format|
      if @participante_mate.update_attributes(params[:participante_mate])
        format.html { redirect_to @participante_mate, notice: 'Participante mate was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @participante_mate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participantes_mates/1
  # DELETE /participantes_mates/1.json
  def destroy
    @participante_mate = ParticipanteMate.find(params[:id])
    @participante_mate.destroy

    respond_to do |format|
      format.html { redirect_to participantes_mates_url }
      format.json { head :ok }
    end
  end
end