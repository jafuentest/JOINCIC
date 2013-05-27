class SugerenciasController < ApplicationController
  # GET /sugerencias
  # GET /sugerencias.json
  def index
    @sugerencias = Sugerencia.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sugerencias }
    end
  end

  # GET /sugerencias/1
  # GET /sugerencias/1.json
  def show
    @sugerencia = Sugerencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @sugerencia }
    end
  end

  # GET /sugerencias/new
  # GET /sugerencias/new.json
  def new
    @sugerencia = Sugerencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @sugerencia }
    end
  end

  # POST /sugerencias
  # POST /sugerencias.json
  def create
    @sugerencia = Sugerencia.new(params[:sugerencia])

    respond_to do |format|
      if @sugerencia.save
        format.html { redirect_to @sugerencia, :notice => 'Sugerencia was successfully created.' }
        format.json { render :json => @sugerencia, :status => :created, :location => @sugerencia }
      else
        format.html { render :action => "new" }
        format.json { render :json => @sugerencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sugerencias/1
  # DELETE /sugerencias/1.json
  def destroy
    @sugerencia = Sugerencia.find(params[:id])
    @sugerencia.destroy

    respond_to do |format|
      format.html { redirect_to sugerencias_url }
      format.json { head :ok }
    end
  end
end
