class PlanesDePatrocinioController < ApplicationController
  # GET /planes_de_patrocinio
  # GET /planes_de_patrocinio.json
  def index
    @planes_de_patrocinio = PlanDePatrocinio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @planes_de_patrocinio }
    end
  end

  # GET /planes_de_patrocinio/1
  # GET /planes_de_patrocinio/1.json
  def show
    @plan_de_patrocinio = PlanDePatrocinio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan_de_patrocinio }
    end
  end

  # GET /planes_de_patrocinio/new
  # GET /planes_de_patrocinio/new.json
  def new
    @plan_de_patrocinio = PlanDePatrocinio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan_de_patrocinio }
    end
  end

  # GET /planes_de_patrocinio/1/edit
  def edit
    @plan_de_patrocinio = PlanDePatrocinio.find(params[:id])
  end

  # POST /planes_de_patrocinio
  # POST /planes_de_patrocinio.json
  def create
    @plan_de_patrocinio = PlanDePatrocinio.new(params[:plan_de_patrocinio])

    respond_to do |format|
      if @plan_de_patrocinio.save
        format.html { redirect_to @plan_de_patrocinio, notice: 'Plan de patrocinio was successfully created.' }
        format.json { render json: @plan_de_patrocinio, status: :created, location: @plan_de_patrocinio }
      else
        format.html { render action: "new" }
        format.json { render json: @plan_de_patrocinio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /planes_de_patrocinio/1
  # PUT /planes_de_patrocinio/1.json
  def update
    @plan_de_patrocinio = PlanDePatrocinio.find(params[:id])

    respond_to do |format|
      if @plan_de_patrocinio.update_attributes(params[:plan_de_patrocinio])
        format.html { redirect_to @plan_de_patrocinio, notice: 'Plan de patrocinio was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @plan_de_patrocinio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planes_de_patrocinio/1
  # DELETE /planes_de_patrocinio/1.json
  def destroy
    @plan_de_patrocinio = PlanDePatrocinio.find(params[:id])
    @plan_de_patrocinio.destroy

    respond_to do |format|
      format.html { redirect_to planes_de_patrocinio_url }
      format.json { head :ok }
    end
  end
end
