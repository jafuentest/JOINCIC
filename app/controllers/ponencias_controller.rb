class PonenciasController < ApplicationController
  # GET /ponencias
  # GET /ponencias.json
  def index
    @ponencias = Ponencia.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ponencias }
    end
  end

  # GET /ponencias/1
  # GET /ponencias/1.json
  def show
    @ponencia = Ponencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ponencia }
    end
  end

  # GET /ponencias/new
  # GET /ponencias/new.json
  def new
    @ponencia = Ponencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ponencia }
    end
  end

  # GET /ponencias/1/edit
  def edit
    @ponencia = Ponencia.find(params[:id])
  end

  # POST /ponencias
  # POST /ponencias.json
  def create
    @ponencia = Ponencia.new(params[:ponencia])

    respond_to do |format|
      if @ponencia.save
        format.html { redirect_to @ponencia, notice: 'Ponencia was successfully created.' }
        format.json { render json: @ponencia, status: :created, location: @ponencia }
      else
        format.html { render action: "new" }
        format.json { render json: @ponencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ponencias/1
  # PUT /ponencias/1.json
  def update
    @ponencia = Ponencia.find(params[:id])

    respond_to do |format|
      if @ponencia.update_attributes(params[:ponencia])
        format.html { redirect_to @ponencia, notice: 'Ponencia was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ponencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ponencias/1
  # DELETE /ponencias/1.json
  def destroy
    @ponencia = Ponencia.find(params[:id])
    @ponencia.destroy

    respond_to do |format|
      format.html { redirect_to ponencias_url }
      format.json { head :ok }
    end
  end
end
