class RifasController < ApplicationController
  skip_before_filter :organizadorLogin, only: [:getParticipantes, :setWinner]
  before_action :set_rifa, only: [:show, :edit, :update, :destroy]

  layout :verificar_layout, except: [:getParticipantes] # Ver al final

  # GET /rifas
  # GET /rifas.json
  def index
    @rifas = Rifa.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rifas }
    end
  end

  # GET /rifas
  # GET /rifas.json
  def rifar
    @rifas = Rifa.order('nombre').select{ |rifa| rifa.participantes.size < rifa.amount }
    respond_to do |format|
      format.html # rifar.html.erb
      format.json { render json: @rifas }
    end
  end

  # GET /rifas/1
  # GET /rifas/1.json
  def show
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
  end

  # POST /rifas
  # POST /rifas.json
  def create
    @rifa = Rifa.new(rifa_params)
    respond_to do |format|
      if @rifa.save
        format.html { redirect_to @rifa, notice: 'Rifa was successfully created' }
        format.json { render json: @rifa, status: :created, location: @rifa }
      else
        format.html { render "new.html.erb" }
        format.json { render json: @rifa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rifas/1
  # PUT /rifas/1.json
  def update
    respond_to do |format|
      if @rifa.update_attributes(rifa_params)
        format.html { redirect_to @rifa, notice: 'Rifa was successfully updated' }
        format.json { head :ok }
      else
        format.html { render 'edit.html.erb' }
        format.json { render json: @rifa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rifas/1
  # DELETE /rifas/1.json
  def destroy
    @rifa.destroy
    respond_to do |format|
      format.html { redirect_to rifas_url }
      format.json { head :ok }
    end
  end

  # POST /rifas/getParticipantes
  # POST /rifas/getParticipantes.json
  # POST /rifas/getParticipantes.html
  def getParticipantes
    @rifa = Rifa.find(rifa_params)
    if @rifa.limit.nil?
      if ParticipanteRifa.all.empty?
        @participantes = Participante.all
      else
        @participantes = Participante.where('id not in (?)', ParticipanteRifa.all.map(&:participante_id) )
      end
    else
      if ParticipanteRifa.all.empty?
        @participantes = Participante.limit @rifa.limite
      else
        @participantes = Participante.where('id not in (?)', ParticipanteRifa.all.map(&:participante_id).limit(@rifa.limite))
      end
    end
    respond_to do |format|
      format.json  { render json: { participantes: @participantes, rifa: @rifa } }
    end
  end

  def setWinner
    @winner = Participante.find(params[:winner][:id])
    @raffle = Rifa.find(params[:raffle][:id])
    @error = nil
    @raffleDone = false
    if @raffle.participantes.include? @winner
      @error = 'El usuario ya gano en esta rifa'
    else
      if @raffle.participantes.size < @raffle.amount
        @raffle.participantes = @raffle.participantes + [@winner]
        @raffle.save
        if @raffle.participantes.size == @raffle.amount
          @raffleDone = true
        end
      else
        @error = 'Todos los sorteos de esta rifa fueron realizados'
      end
    end

    # begin
    #   cedula = @winner.cedula.to_s
    #   body = "Usted gano la rifa #{@raffle.nombre.to_s} comuníquese con algún organizador"
    #   result = Net::HTTP.get(URI.parse("http://messages.joincic.com.ve/byCedulas?no_validate&cedulas[]="+cedula+"&body="+body))
    # rescue => ex
    #   logger.warn "Can't Send SMS to #{@winner.cedula.to_s} message: #{ex.backtrace}: #{ex.message} (#{ex.class})"
    # end

    respond_to do |format|
      format.json  { render json: [winner: @winner, error: @error, raffle: @raffle, raffleDone: @raffleDone] }
    end
  end

  private

  def verificar_layout
    case action
    when :rifar
      'movil'
    else
      'application'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def rifa_params
    params.require(:rifa).permit(:nombre, :capacidad)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_rifa
    @zona = Zona.find(params[:id])
  end
end
