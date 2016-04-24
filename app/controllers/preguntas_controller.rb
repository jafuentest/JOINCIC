class PreguntasController < ApplicationController
  skip_before_filter :organizadorLogin, only: [:new, :create, :index]
  before_action :set_pregunta, only: [:show, :destroy, :aprobar]

  layout :verificar_layout #Ver al final

  # GET /preguntas
  # GET /preguntas.json
  def index
    @num_ponencia = 0
    @hay_ponencia = false
    if params[:ponencia_id].present?
      if Ponencia.find(params[:ponencia_id]).present?
        @preguntas = Pregunta.where(ponencia_id: params[:ponencia_id]).includes(:ponencia, :participante).aceptada
        @hay_ponencia = true
        @num_ponencia = params[:ponencia_id]
      end
    end

    @preguntas = Pregunta.aceptada.includes(:ponencia, :participante).limit(50) unless @hay_ponencia
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @preguntas }
    end
  end

  def panel
    @num_ponencia = 0
    @hay_ponencia = false
    if params[:ponencia].present?
      if Ponencia.find(params[:ponencia]).present?
        @preguntas = Pregunta.includes(:ponencia, :participante).find_by_ponencia_id(params[:ponencia_id]).order('id DESC')
        @hay_ponencia = true
        @num_ponencia = params[:ponencia].to_i
      end
    end

    @preguntas = Pregunta.includes(:ponencia, :participante).limit(50).order('id DESC') unless @hay_ponencia
    @ultimaid = @preguntas.maximum('id')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @preguntas }
    end
  end

  # GET /preguntas/1
  # GET /preguntas/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pregunta }
    end
  end

  # GET /preguntas/new
  # GET /preguntas/new.json
  def new
    ahora = Time.now - (60 * 60 * 4.5)
    @ponencias = Ponencia.where('hora_ini <= ? AND hora_fin >= ?', ahora, ahora)
    @pregunta = Pregunta.new
  end

  # POST /preguntas
  # POST /preguntas.json
  def create
    @ponencias = Ponencia.all
    participante = Participante.find_by_cedula(params[:participante_cedula])
    if participante.present?
      params[:pregunta][:participante_id] = participante.id
      @pregunta = Pregunta.new(pregunta_params)
      respond_to do |format|
        if @pregunta.save
          format.html { redirect_to new_pregunta_path , notice: 'Pregunta creada satisfactoriamente.' }
          format.json { render json: @pregunta, status: :created, location: @pregunta }
        else
          format.html { render 'new.html.erb' }
          format.json { render json: @pregunta.errors, status: :unprocessable_entity }
        end
      end
    else
      @pregunta = Pregunta.new(pregunta_params)
      flash[:notice] = 'Participante no registrado.'
      render 'new.html.erb'
    end
  end

  # DELETE /preguntas/1
  # DELETE /preguntas/1.json
  def destroy
    @pregunta.destroy
    respond_to do |format|
      format.html { redirect_to panel_preguntas_url }
      format.json { head :ok }
    end
  end

  def aprobar
    @pregunta.aceptada = true
    respond_to do |format|
      if @pregunta.save
        flash[:notice] = 'Pregunta aceptada.'
        format.html { redirect_to panel_preguntas_url }
        format.json { head :ok }
      else
        flash[:notice] = 'Pregunta sin cambios.'
        format.html { redirect_to panel_preguntas_url }
        format.json { render json: @pregunta.errors, status: :unprocessable_entity }
      end
    end
  end

  def dame_preguntas
    ponencia = ''
    ultimoid = ' id > 0 '
    aceptada = ''
    orden = 'id DESC'

    if params[:ponencia_id].present?
      if Ponencia.find(params[:ponencia_id]).present?
        ponencia = " AND ponencia_id = #{params[:ponencia_id]}"
      end
    end
    if params[:ultimoid].present? and params[:ultimoid].to_i > 0
      ultimoid = " id > #{params[:ultimoid]}"
    end
    if params[:aceptada].present?
      aceptada = ' AND aceptada = 1 '
      orden = 'id ASC'
    end

    @preguntas = Pregunta.where(ultimoid+ponencia+aceptada).order(orden)

    render json: @preguntas.to_json(
      include: { ponencia: { only: :titulo }, participante: { only: [:nombre, :apellido] } },
      except:  [:participante_id, :ponencia_id])
  end

  private

  def verificar_layout
    if %w('new create show index').include?(action_name)
      'movil'
    else
      'application'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pregunta_params
    params.require(:pregunta).permit(:mensaje, :participante_id, :ponencia_id, :aceptada)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_pregunta
    @pregunta = Pregunta.find(params[:id])
  end
end
