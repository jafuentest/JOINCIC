class ProblemasController < ApplicationController
  layout "application", :except => [:descargarEntrada, :descargarSalida]
  skip_before_filter :organizadorLogin, :only => [:index, :show, :descargarEntrada, :descargarSalida]
  # GET /problemas
  # GET /problemas.json
  def index
    @problemas = Problema.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @problemas }
    end
  end
  
  def descargarEntrada
    @problema = Problema.find(params[:id])
    if @problema
      filename = @problema.titulo
      headers['Content-Type'] = 'text/plain'
      headers['Content-Disposition'] = 'attachment; filename='+@problema.titulo+' entrada.txt'
    end
  end
  
  def descargarSalida
    @problema = Problema.find(params[:id])
    if @problema
      headers['Content-Type'] = 'text/plain'
      headers['Content-Disposition'] = 'attachment; filename='+@problema.titulo+' salida.txt'
    end
  end

  # GET /problemas/1
  # GET /problemas/1.json
  def show
    @problema = Problema.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @problema }
    end
  end

  # GET /problemas/new
  # GET /problemas/new.json
  def new
    @problema = Problema.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @problema }
    end
  end

  # GET /problemas/1/edit
  def edit
    @problema = Problema.find(params[:id])
  end

  # POST /problemas
  # POST /problemas.json
  def create
    @problema = Problema.new(params[:problema])

    respond_to do |format|
      if @problema.save
        format.html { redirect_to @problema, :notice => 'Problema was successfully created.' }
        format.json { render :json => @problema, :status => :created, :location => @problema }
      else
        format.html { render :action => "new" }
        format.json { render :json => @problema.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /problemas/1
  # PUT /problemas/1.json
  def update
    @problema = Problema.find(params[:id])

    respond_to do |format|
      if @problema.update_attributes(params[:problema])
        format.html { redirect_to @problema, :notice => 'Problema was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @problema.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /problemas/1
  # DELETE /problemas/1.json
  def destroy
    @problema = Problema.find(params[:id])
    @problema.destroy

    respond_to do |format|
      format.html { redirect_to problemas_url }
      format.json { head :ok }
    end
  end
end
