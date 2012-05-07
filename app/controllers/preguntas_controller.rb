class PreguntasController < ApplicationController
  skip_before_filter :estarLogueado, :except => [:panel, :edit, :update, :destroy]
  layout :verificar_layout #Ver al final
  # GET /preguntas
  # GET /preguntas.json
  def index
    @num_ponencia = 0
    @hay_ponencia = false
    if params[:ponencia_id].present?
      if Ponencia.find(params[:ponencia_id]).present?
        @preguntas = Pregunta.where(:ponencia_id => params[:ponencia_id].to_i).includes(:ponencia, :participante).aceptada
        @hay_ponencia = true
        @num_ponencia = params[:ponencia_id].to_i
      end
    end

    unless @hay_ponencia
      @preguntas = Pregunta.aceptada.includes(:ponencia, :participante).limit(50)
    end

    #@ultimaid = @preguntas.maximum("id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @preguntas }
    end
  end

  def panel
    @num_ponencia = 0
    @hay_ponencia = false
    if params[:ponencia].present?
      if Ponencia.find(params[:ponencia]).present?
        @preguntas = Pregunta.includes(:ponencia, :participante).find_by_ponencia_id(params[:ponencia_id]).order("id DESC")
        @hay_ponencia = true
        @num_ponencia = params[:ponencia].to_i
      end
    end

    unless @hay_ponencia
      @preguntas = Pregunta.includes(:ponencia, :participante).limit(50).order("id DESC")
    end

    @ultimaid = @preguntas.maximum("id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @preguntas }
    end
  end

  # GET /preguntas/1
  # GET /preguntas/1.json
  def show
    @pregunta = Pregunta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @pregunta }
    end
  end

  # GET /preguntas/new
  # GET /preguntas/new.json
  def new
    @pregunta = Pregunta.new
    @ponencias = Ponencia.all
  end

  # GET /preguntas/1/edit
  def edit
    @pregunta = Pregunta.find(params[:id])
    @ponencias = Ponencia.all
  end

  # POST /preguntas
  # POST /preguntas.json
  def create
    @ponencias = Ponencia.all
    p = Participante.find_by_cedula(params[:participante_cedula])
    if p.present?
      params[:pregunta][:participante_id] = p.id

      @pregunta = Pregunta.new(params[:pregunta])

      respond_to do |format|
        if @pregunta.save
          format.html { redirect_to @pregunta, notice => 'Pregunta creada satisfactoriamente.' }
          format.json { render :json => @pregunta, status => :created, location => @pregunta }
        else
          format.html { render "new.html.erb" }
          format.json { render :json => @pregunta.errors, status => :unprocessable_entity }
        end
      end
    else
      @pregunta = Pregunta.new(params[:pregunta])
      flash[:notice] = 'Participante no registrado.'
      render "new.html.erb"
    end
  end

  # PUT /preguntas/1
  # PUT /preguntas/1.json
  def update
    @pregunta = Pregunta.find(params[:id])

    respond_to do |format|
      if @pregunta.update_attributes(params[:pregunta])
        format.html { redirect_to @pregunta, notice => 'Pregunta was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render "edit.html.erb" }
        format.json { render :json => @pregunta.errors, status => :unprocessable_entity }
      end
    end
  end

  # DELETE /preguntas/1
  # DELETE /preguntas/1.json
  def destroy
    @pregunta = Pregunta.find(params[:id])
    @pregunta.destroy

    respond_to do |format|
      format.html { redirect_to preguntas_url }
      format.json { head :ok }
    end
  end

  def aprobar
    p = Pregunta.find(params[:id])
    p.aceptada = true
    respond_to do |format|
      if p.save
        flash[:notice] = 'Pregunta aceptada.'
        format.html { redirect_to panel_preguntas_url }
        format.json { head :ok }
      else
        flash[:notice] = 'Pregunta sin cambios.'
        format.html { redirect_to panel_preguntas_url }
        format.json { render :json => p.errors, status => :unprocessable_entity }
      end
    end
  end

  def dame_preguntas
    ponencia = ""
    ultimoid = " id > 0 "
    aceptada = ""
    orden = "id DESC"

    if params[:ponencia_id].present?
      if Ponencia.find(params[:ponencia_id]).present?
        ponencia = " AND ponencia_id = "+(params[:ponencia_id].to_i).to_s
      end
    end
    if params[:ultimoid].present? and params[:ultimoid].to_i > 0
      ultimoid = " id > "+(params[:ultimoid].to_i).to_s
    end
    if params[:aceptada].present?
      aceptada = " AND aceptada = 1 "
      orden = "id ASC"
    end

    @preguntas = Pregunta.where(ultimoid+ponencia+aceptada).order(orden)

    render :json => @preguntas.to_json(:include => {:ponencia => { :only => :titulo }, :participante => { :only => [:nombre, :apellido] } }, :except => [:participante_id, :ponencia_id])
  end

  private
    def verificar_layout
    case action_name
    when "new", "create", "edit", "update", "show", "index"
      "movil"
    else
      "application"
    end
  end

end
