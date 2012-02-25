class MaterialesPopController < ApplicationController
  # GET /materiales_pop
  # GET /materiales_pop.json
  def index
    @materiales_pop = MaterialPop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @materiales_pop }
    end
  end

  # GET /materiales_pop/1
  # GET /materiales_pop/1.json
  def show
    @material_pop = MaterialPop.find(params[:id])
		@disponibilidad = @material_pop.cantidad - ParticipanteMate.count(:conditions => { :id_mat => @material_pop.id })

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @material_pop }
    end
  end

  # GET /materiales_pop/new
  # GET /materiales_pop/new.json
  def new
    @material_pop = MaterialPop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @material_pop }
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

    respond_to do |format|
      if @material_pop.save
        format.html { redirect_to @material_pop, notice: 'Material pop was successfully created.' }
        format.json { render json: @material_pop, status: :created, location: @material_pop }
      else
        format.html { render action: "new" }
        format.json { render json: @material_pop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /materiales_pop/1
  # PUT /materiales_pop/1.json
  def update
    @material_pop = MaterialPop.find(params[:id])

    respond_to do |format|
      if @material_pop.update_attributes(params[:material_pop])
        format.html { redirect_to @material_pop, notice: 'Material pop was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @material_pop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materiales_pop/1
  # DELETE /materiales_pop/1.json
  def destroy
    @material_pop = MaterialPop.find(params[:id])
    @material_pop.destroy

    respond_to do |format|
      format.html { redirect_to materiales_pop_url }
      format.json { head :ok }
    end
  end
end
