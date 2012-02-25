class ParticipantesController < ApplicationController
  # GET /participantes
  # GET /participantes.json
  def index
    @participantes = Participante.find( :all, :conditions => { :eliminado => false }, :order => 'created_at DESC', :limit => 50 )
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participantes }
    end
  end

  # GET /participantes/1
  # GET /participantes/1.json
  def show
    @participante = Participante.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participante }
    end
  end
  
  # GET /participantes/new
  # GET /participantes/new.json
  def new
    @participante = Participante.new
    @zonas = arreglo
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participante }
    end
  end

  # POST /participantes
  # POST /participantes.json
  def create
    @participante = Participante.new(params[:participante])
	@zonas = arreglo
	
    respond_to do |format|
      if @participante.save
        format.html { redirect_to @participante, notice: 'Participante was successfully created.' }
        format.json { render json: @participante, status: :created, location: @participante }
      else
        format.html { render action: "new" }
        format.json { render json: @participante.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /participantes/1/edit
  def edit
    @participante = Participante.find(params[:id])
	@zonas = arregloUpdate(@participante.id_zona)
  end

  # PUT /participantes/1
  # PUT /participantes/1.json
  def update
    @participante = Participante.find(params[:id])
	@zonas = arregloUpdate(@participante.id_zona)
	
    respond_to do |format|
      if @participante.update_attributes(params[:participante])
        format.html { redirect_to @participante, notice: 'Participante was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @participante.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participantes/1
  # DELETE /participantes/1.json
  def destroy
    @participante = Participante.find(params[:id])
    @participante.update_attribute(:eliminado, true)

    respond_to do |format|
      format.html { redirect_to participantes_url }
      format.json { head :ok }
    end
  end
  
  def arreglo
    zonas = Zona.all
    zonas.each do |z|
      if z.capacidad <= Participante.count(:conditions => { :id_zona => z.id })
        zonas.delete(z)
      end
    end
    zonas
  end
  
  def arregloUpdate (idZona)
    zonas = Zona.all
    zonas.each do |z|
      if z.capacidad <= Participante.count(:conditions => { :id_zona => z.id })
        if z.id != idZona
		  zonas.delete(z)
		end
      end
    end
    zonas
  end
  
end
