class PatrocinantesController < ApplicationController
  # GET /patrocinantes
  # GET /patrocinantes.json
  def index
    @patrocinantes = Patrocinante.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patrocinantes }
    end
  end

  # GET /patrocinantes/1
  # GET /patrocinantes/1.json
  def show
    @patrocinante = Patrocinante.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patrocinante }
    end
  end

  # GET /patrocinantes/new
  # GET /patrocinantes/new.json
  def new
    @patrocinante = Patrocinante.new
    @planes = Plan.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patrocinante }
    end
  end

  # GET /patrocinantes/1/edit
  def edit
    @planes = Plan.all
    @patrocinante = Patrocinante.find(params[:id])
  end

  # POST /patrocinantes
  # POST /patrocinantes.json
  def create
    @patrocinante = Patrocinante.new(params[:patrocinante])
    @planes = Plan.all

    respond_to do |format|
      if @patrocinante.save
        format.html { redirect_to @patrocinante, notice: 'Patrocinante was successfully created.' }
        format.json { render json: @patrocinante, status: :created, location: @patrocinante }
      else
        format.html { render action: "new" }
        format.json { render json: @patrocinante.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /patrocinantes/1
  # PUT /patrocinantes/1.json
  def update
    @patrocinante = Patrocinante.find(params[:id])
    @planes = Plan.all

    respond_to do |format|
      if @patrocinante.update_attributes(params[:patrocinante])
        format.html { redirect_to @patrocinante, notice: 'Patrocinante was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @patrocinante.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patrocinantes/1
  # DELETE /patrocinantes/1.json
  def destroy
    @patrocinante = Patrocinante.find(params[:id])
    @patrocinante.destroy

    respond_to do |format|
      format.html { redirect_to patrocinantes_url }
      format.json { head :ok }
    end
  end
end
