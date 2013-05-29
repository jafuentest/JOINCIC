class ParticipantesMesasController < ApplicationController
  # GET /participantes_mesas/new
  # GET /participantes_mesas/new.json
  def new
    numero_regex = /^[0-9]+$/
    
    if params.has_key?(:entrada) && params[:entrada] != ''
      if params[:entrada] =~ numero_regex
        @participante = Participante.find_by_entrada(params[:entrada])
        if @participante.nil?
          flash[:notice] = 'No se encontró ningún participante cuya entrada sea: <br/>'.html_safe + params[:entrada]
          redirect_to buscar_participantes_mesas_path
        elsif @participante.eliminado
          flash[:notice] = 'Error: El participante fue eliminado del sistema'
          redirect_to buscar_participantes_mesas_path
        else
          @mesas_de_trabajo = mesasDisponibles
          @participante_mesa = ParticipanteMesa.new
          respond_to do |format|
            format.html { render 'new.html.erb' }
          end
        end
      else
        flash[:notice] = 'Error: Número de entrada inválido'
        redirect_to buscar_participantes_mesas_path
      end
    else
      flash[:notice] = 'Ingresa el número de entrada del participante'
      redirect_to buscar_participantes_mesas_path
    end
  end
  
  # POST /participantes_mesas
  # POST /participantes_mesas.json
  def create
    pid = params[:participante_mesa][:participante_id]
    mid = params[:participante_mesa][:mesa_de_trabajo_id]
    existe = ParticipanteMesa.find_by_participante_id_and_mesa_de_trabajo_id(pid, mid)
    if existe
      flash[:notice] = 'El participante ya se encuentra registrado para esta mesa'
      redirect_to existe
    else
      @participante_mesa = ParticipanteMesa.new(params[:participante_mesa])
      p = Participante.find(pid)
      m = MesaDeTrabajo.find(mid)
      @participante_mesa.participante = p
      @participante_mesa.mesa_de_trabajo = m

      respond_to do |format|
        if @participante_mesa.save
          flash[:notice] = 'Participante registrado con éxito.'
          format.html { redirect_to @participante_mesa }
          format.json { render json => @participante_mesa, status => :created, location => @participante_mesa }
        else
          format.html { render 'new.html.erb' }
          format.json { render json => @participante_mesa.errors, status => :unprocessable_entity }
        end
      end
    end
  end
  
  # GET /participantes_mesas/1
  # GET /participantes_mesas/1.json
  def show
    @participante_mesa = ParticipanteMesa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json => @participante_mesa }
    end
  end
  
  # DELETE /participantes_mesas/1
  # DELETE /participantes_mesas/1.json
  def destroy
    @participante_mesa = ParticipanteMesa.find(params[:id])
    cedula = @participante_mesa.participante.cedula
    @participante_mesa.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'participantes_mesas', :action => 'new', :entrada => entrada }
      format.json { head :ok }
    end
  end
  
  def mesasDisponibles
    MesaDeTrabajo.find(:all, :conditions => {:sorteada => false})
  end
end
