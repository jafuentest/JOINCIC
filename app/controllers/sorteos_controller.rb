class SorteosController < ApplicationController
  # GET /sorteos
  # GET /sorteos.json
  def index
    @sorteos = Sorteo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sorteos }
    end
  end

  # GET /sorteos/1
  # GET /sorteos/1.json
  def show
    @sorteo = Sorteo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sorteo }
    end
  end

  # GET /sorteos/new
  # GET /sorteos/new.json
  def new
    @sorteo = Sorteo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sorteo }
    end
  end

  # GET /sorteos/1/edit
  def edit
    @sorteo = Sorteo.find(params[:id])
  end

  # POST /sorteos
  # POST /sorteos.json
  def create
    @sorteo = Sorteo.new(params[:sorteo])

    respond_to do |format|
      if @sorteo.save
        format.html { redirect_to @sorteo, notice: 'Sorteo was successfully created.' }
        format.json { render json: @sorteo, status: :created, location: @sorteo }
      else
        format.html { render action: "new" }
        format.json { render json: @sorteo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sorteos/1
  # PUT /sorteos/1.json
  def update
    @sorteo = Sorteo.find(params[:id])

    respond_to do |format|
      if @sorteo.update_attributes(params[:sorteo])
        format.html { redirect_to @sorteo, notice: 'Sorteo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sorteo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sorteos/1
  # DELETE /sorteos/1.json
  def destroy
    @sorteo = Sorteo.find(params[:id])
    @sorteo.destroy

    respond_to do |format|
      format.html { redirect_to sorteos_url }
      format.json { head :ok }
    end
  end
end
