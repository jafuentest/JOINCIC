class ProgramasController < ApplicationController
  before_action :set_programa, only: [:show, :destroy, :serve]

  skip_before_filter :organizadorLogin, only: [:new, :create, :index, :show, :validar, :listar, :serve_privado]

  # GET /programas
  # GET /programas.json
  def index
    if session[:privilegios] == 'grupo'
      @programas = Programa.where( grupo_id: session[:usuario_id])
    elsif session[:privilegios] == 'organizador'
      @programas = Programa.all
    else
      @programas = []
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programas }
    end
  end

  # GET /programas/1
  # GET /programas/1.json
  def show
    if session[:privilegios] == 'organizador' || (session[:privilegios] == 'grupo' && session[:usuario_id] == params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @programa }
      end
    else
      flash[:notice] = 'La página que intentó acceder, solo está disponible para el personal organizador del evento'
      redirect_to perfil_path
    end
  end

  # GET /programas/new
  # GET /programas/new.json
  def new
    @programa = Programa.new
    @problemas = Problema.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @programa }
    end
  end

  def listar
    data = []
    contentData = ''
    Programa.find_all_by_estado(:procesando).each do |p|
      caseName = p.problema.titulo 
      language = p.mime_type

      filename = p.filename
      if filename.include? '.java'
        language = 'java'
      else 
        if filename.include? '.cpp'
          language = 'c++'
        else 
          if filename.include?  '.py'
          language = 'python'
          else
             if filename.include?  '.c' 
              language = 'c'
             end
          end
        end
      end
      data += [{ id: p.id, case: caseName, language: language, filename: filename }]
    end
    render json: data
  end

  def validar
    if params[:salt] != SALT
      raise ActionController::RoutingError.new('Forbidden')
    end
    #confiemos ciegamente xDD :P 
    @programa = Programa.find(params[:id])
    
    @programa.save
    render text: 'ok'
  end

  def serve_privado
    if params[:salt] != SALT
      raise ActionController::RoutingError.new('Forbidden')
    end
    @programa = Programa.find(params[:id])
    send_data(@programa.data, type: @programa.mime_type, filename: "#{@programa.filename}", disposition: 'inline')
  end

  # POST /programas
  # POST /programas.json
  def create
    # build a programa and pass it into a block to set other attributes
    @programa = Programa.new(params[:programa]) do |t|
      if params[:programa][:data]
        t.data      = params[:programa][:data].read
        t.filename  = params[:programa][:data].original_filename
        t.mime_type = params[:programa][:data].content_type
      end
    end

    @programa.grupo_id = session[:usuario_id]
    respond_to do |format|
      if @programa.save
        format.html { redirect_to @programa, notice: 'Programa registrado con éxito, espere por la validación del servidor.' }
        format.json { render json: @programa, status: :created, location: @programa }
      else
        @problemas = Problema.all
        format.html { render action: :new }
        format.json { render json: @programa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programas/1
  # DELETE /programas/1.json
  def destroy
    @programa.destroy
    respond_to do |format|
      format.html { redirect_to programas_url }
      format.json { head :ok }
    end
  end

  def serve
    send_data(@programa.data, type: @programa.mime_type, filename: "#{@programa.filename}", disposition: 'inline')
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def programa_params
    params.require(:programa).permit(:problema_id, :grupo_id, :estado, :data, :filename, :mime_type)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_programa
    @programa = Programa.find(params[:id])
  end
end
