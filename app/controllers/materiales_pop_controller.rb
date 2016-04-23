class MaterialesPopController < ApplicationController
  before_action :set_material_pop, only: [:show, :edit, :update, :destroy]

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
    @material_pop = MaterialPop.new(material_pop_params)
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
        format.html { redirect_to @material_pop, notice: 'El material fue agregado con éxito.' }
        format.json { render json: @material_pop, status: :created, location: @material_pop }
      end
    else
      respond_to do |format|
        format.html { render 'new.html.erb' }
        format.json { render json: @material_pop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /materiales_pop/1
  # PUT /materiales_pop/1.json
  def update
    respond_to do |format|
      if @material_pop.update_attributes(material_pop_params)
        format.html { redirect_to @material_pop, notice: 'El material fue actualizado con éxito.' }
        format.json { head :ok }
      else
        format.html { render 'edit.html.erb' }
        format.json { render json: @material_pop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materiales_pop/1
  # DELETE /materiales_pop/1.json
  def destroy
    @material_pop.destroy
    ParticipanteMate.destroy_all(material_pop_id: params[:id])
    respond_to do |format|
      format.html { redirect_to materiales_pop_url }
      format.json { head :ok }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def material_pop_params
    params.require(:material_pop).permit(:nombre, :cantidad)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_material_pop
    @material_pop = MaterialPop.find(params[:id])
  end
end
