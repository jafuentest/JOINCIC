class MaterialesPopController < ApplicationController
  # GET /materiales_pop
  # GET /materiales_pop.json
  def index
    @materiales_pop = MaterialPop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json => @materiales_pop }
    end
  end

  # GET /materiales_pop/1
  # GET /materiales_pop/1.json
  def show
    @material_pop = MaterialPop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json => @material_pop }
    end
  end

  # GET /materiales_pop/new
  # GET /materiales_pop/new.json
  def new
    @material_pop = MaterialPop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json => @material_pop }
    end
  end

  # GET /materiales_pop/1/edit
  def edit
    @material_pop = MaterialPop.find(params[:id])
  end

  # POST /materiales_pop
  # POST /materiales_pop.json
  def create
    @material_pop = MaterialPop.new(params[:material_pop])
    
    if @material_pop.save
      Participante.all.each do |p|
        if p.participantes_mates.size > 0
          pm = ParticipanteMate.new
          pm.participante_id = p.id
          pm.material_pop_id = @material_pop.id
          pm.entregado = false
          pm.save
        end
      end
      
      respond_to do |format|
        format.html { redirect_to @material_pop, notice => "El material fue agregado con &eacute;xito." }
        format.json { render json => @material_pop, status => :created, location =>  @material_pop }
      end
    
    else
      respond_to do |format|
        format.html { render "new.html.erb" }
        format.json { render json => @material_pop.errors, status => :unprocessable_entity }
      end
    end
  end

  # PUT /materiales_pop/1
  # PUT /materiales_pop/1.json
  def update
    @material_pop = MaterialPop.find(params[:id])

    respond_to do |format|
      if @material_pop.update_attributes(params[:material_pop])
        format.html { redirect_to @material_pop, notice => "El material fue actualizado con &eacute;xito." }
        format.json { head :ok }
      else
        format.html { render "edit.html.erb" }
        format.json { render json => @material_pop.errors, status => :unprocessable_entity }
      end
    end
  end

  # DELETE /materiales_pop/1
  # DELETE /materiales_pop/1.json
  def destroy
    @material_pop = MaterialPop.find(params[:id])
    @material_pop.participantes_mates.each do |entrega|
      entrega.destroy
    end
    
    @material_pop.destroy

    respond_to do |format|
      format.html { redirect_to materiales_pop_url }
      format.json { head :ok }
    end
  end
end
