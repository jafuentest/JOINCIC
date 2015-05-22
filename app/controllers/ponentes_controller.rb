class PonentesController < ApplicationController
  skip_before_filter :organizadorLogin, :only => [:index, :show]
  
  # GET /ponentes
  # GET /ponentes.json
  def index
    @ponentes = Ponente.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ponentes }
    end
  end

  # GET /ponentes/1
  # GET /ponentes/1.json
  def show
    @ponente = Ponente.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ponente }
    end
  end

  # GET /ponentes/new
  # GET /ponentes/new.json
  def new
    @ponente = Ponente.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ponente }
    end
  end

  # GET /ponentes/1/edit
  def edit
    @ponente = Ponente.find(params[:id])
  end

  # POST /ponentes
  # POST /ponentes.json
  def create
    @ponente = Ponente.new(params[:ponente])
    respond_to do |format|
      if @ponente.save
        format.html { redirect_to @ponente, notice => 'Ponente creado con éxito' }
        format.json { render :json => @ponente, status => :created, location => @ponente }
      else
        format.html { render 'new.html.erb' }
        format.json { render :json => @ponente.errors, status => :unprocessable_entity }
      end
    end
  end

  # PUT /ponentes/1
  # PUT /ponentes/1.json
  def update
    @ponente = Ponente.find(params[:id])
    respond_to do |format|
      if @ponente.update_attributes(params[:ponente])
        format.html { redirect_to @ponente, notice => 'Ponente actualizado con éxito' }
        format.json { head :ok }
      else
        format.html { render 'edit.html.erb' }
        format.json { render :json => @ponente.errors, status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ponentes/1
  # DELETE /ponentes/1.json
  def destroy
    @ponente = Ponente.find(params[:id])
    @ponente.destroy
    respond_to do |format|
      format.html { redirect_to ponentes_url }
      format.json { head :ok }
    end
  end
end
