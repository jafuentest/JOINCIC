class OrganizadoresController < ApplicationController
  # GET /organizadores
  # GET /organizadores.json
  def index
    @organizadores = Organizador.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizadores }
    end
  end

  # GET /organizadores/1
  # GET /organizadores/1.json
  def show
    @organizador = Organizador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organizador }
    end
  end

  # GET /organizadores/new
  # GET /organizadores/new.json
  def new
    @organizador = Organizador.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organizador }
    end
  end

  # GET /organizadores/1/edit
  def edit
    @organizador = Organizador.find(params[:id])
  end

  # POST /organizadores
  # POST /organizadores.json
  def create
    @organizador = Organizador.new(params[:organizador])
    
    respond_to do |format|
      if @organizador.save
        format.html { redirect_to @organizador, notice: "El organizador fue creado con éxito" }
        format.json { render json: @organizador, status: :created, location: @organizador }
      else
        format.html { render action: "new" }
        format.json { render json: @organizador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizadores/1
  # PUT /organizadores/1.json
  def update
    @organizador = Organizador.find(params[:id])

    respond_to do |format|
      if @organizador.update_attributes(params[:organizador])
        format.html { redirect_to @organizador, notice: "El organizador fue modificado con éxito" }
        format.json { head :ok }
      else
        format.html { render action: "editar" }
        format.json { render json: @organizador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizadores/1
  # DELETE /organizadores/1.json
  def destroy
    @organizador = Organizador.find(params[:id])
    @organizador.destroy

    respond_to do |format|
      format.html { redirect_to organizadores_url }
      format.json { head :ok }
    end
  end
end
