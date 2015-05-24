class PonenciasController < ApplicationController
  skip_before_filter :organizadorLogin, :only => [:index, :show]

  # GET /ponencias
  # GET /ponencias.json
  def index
    @ponencias = Ponencia.all
    respond_to do |format|
      format.html
      format.json { render :json => @ponencias.to_json(:include => [:ponente]) }
    end
  end

  # GET /ponencias/1
  # GET /ponencias/1.json
  def show
    @ponencia = Ponencia.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @ponencia.to_json (:include => [:ponente]) }
    end
  end

  # GET /ponencias/new
  def new
    @ponencia = Ponencia.new
    @ponentes = Ponente.all
    @patrocinantes = Patrocinante.all
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /ponencias/1/edit
  def edit
    @ponencia = Ponencia.find(params[:id])
    @ponentes = Ponente.all
    @patrocinantes = Patrocinante.all
  end

  # POST /ponencias
  def create
    @ponencia = Ponencia.new(params[:ponencia])
    respond_to do |format|
      if @ponencia.save
        format.html { redirect_to @ponencia, notice => 'Ponencia was successfully created.' }
      else
        @ponentes = Ponente.all
        @patrocinantes = Patrocinante.all
        format.html { render 'new.html.erb' }
      end
    end
  end

  # PUT /ponencias/1
  def update
    @ponencia = Ponencia.find(params[:id])
    respond_to do |format|
      if @ponencia.update_attributes(params[:ponencia])
        format.html { redirect_to @ponencia, notice => 'Ponencia was successfully updated.' }
      else
        @ponentes = Ponente.all
        @patrocinantes = Patrocinante.all
        format.html { render 'edit.html.erb' }
      end
    end
  end

  # DELETE /ponencias/1
  def destroy
    @ponencia = Ponencia.find(params[:id])
    @ponencia.destroy
    respond_to do |format|
      format.html { redirect_to ponencias_url }
    end
  end
end
