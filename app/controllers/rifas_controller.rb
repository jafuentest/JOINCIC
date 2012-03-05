class RifasController < ApplicationController
  # GET /rifas
  # GET /rifas.json
  def index
    @rifas = Rifa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rifas }
    end
  end

  # GET /rifas/1
  # GET /rifas/1.json
  def show
    @rifa = Rifa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rifa }
    end
  end

  # GET /rifas/new
  # GET /rifas/new.json
  def new
    @rifa = Rifa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rifa }
    end
  end

  # GET /rifas/1/edit
  def edit
    @rifa = Rifa.find(params[:id])
  end

  # POST /rifas
  # POST /rifas.json
  def create
    @rifa = Rifa.new(params[:rifa])

    respond_to do |format|
      if @rifa.save
        format.html { redirect_to @rifa, notice: 'Rifa was successfully created.' }
        format.json { render json: @rifa, status: :created, location: @rifa }
      else
        format.html { render action: "new" }
        format.json { render json: @rifa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rifas/1
  # PUT /rifas/1.json
  def update
    @rifa = Rifa.find(params[:id])

    respond_to do |format|
      if @rifa.update_attributes(params[:rifa])
        format.html { redirect_to @rifa, notice: 'Rifa was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rifa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rifas/1
  # DELETE /rifas/1.json
  def destroy
    @rifa = Rifa.find(params[:id])
    @rifa.destroy

    respond_to do |format|
      format.html { redirect_to rifas_url }
      format.json { head :ok }
    end
  end
end
