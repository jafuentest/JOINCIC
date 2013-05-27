class GruposController < ApplicationController
  skip_before_filter :organizadorLogin, :only => [:new, :create, :perfil]
  before_filter      :grupoLogin, :only => [:perfil]
  
  # GET /perfil
  # GET /perfil.json
  def perfil
    @grupo = Grupo.find(session[:usuario_id])
    
    respond_to do |format|
      format.html # perfil.html.erb
    end
  end
  
  # GET /grupos/1/reiniciarClave
  def reiniciarClave
    @grupo = Grupo.find(params[:id])
    @grupo.update_attribute(:clave, params[:clave])
    flash[:notice] = "La clave del grupo fue cambiada a '" + params[:clave] + "'"
    redirect_to @grupo
  end
  
  # GET /grupos
  # GET /grupos.json
  def index
    @grupos = Grupo.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @grupos }
    end
  end
  
  # GET /grupos/1
  # GET /grupos/1.json
  def show
    @grupo = Grupo.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @grupo }
    end
  end
  
  # GET /grupos/new
  # GET /grupos/new.json
  def new
    @grupo = Grupo.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @grupo }
    end
  end
  
  # POST /grupos
  # POST /grupos.json
  def create
    @grupo = Grupo.new(params[:grupo])
    @p1 = Participante.find_by_cedula(params[:integrante1])
    @p2 = Participante.find_by_cedula(params[:integrante2])
    if @p1 && @p2
      if @p1.grupo.nil? && @p2.grupo.nil?
        respond_to do |format|
          if @grupo.save
            @p1.grupo = @p2.grupo = @grupo
            @p1.save
            @p2.save
            session[:usuario_id]  = @grupo.id.to_s
            session[:privilegios] = "grupo"
            format.html { redirect_to perfil_grupos_path, :notice => "Su grupo ha sido registrado exitosamente." }
            format.json { render :json => @grupo, :status => :created, :location => @grupo }
          else
            format.html { render :action => "new" }
            format.json { render :json => @grupo.errors, :status => :unprocessable_entity }
          end
        end
      else
        flash[:notice] = "Error: Uno de los participantes que ingresó ya se encuentra en otro grupo"
        respond_to do |format|
          format.html { render :action => "new" }
        end
      end
    else
      flash[:notice] = "Error: Debe registrar dos participantes"
      respond_to do |format|
        format.html { render :action => "new" }
      end
    end
  end
  
  # DELETE /grupos/1
  # DELETE /grupos/1.json
  def destroy
    @grupo = Grupo.find(params[:id])
    @grupo.destroy
    
    respond_to do |format|
      format.html { redirect_to grupos_url }
      format.json { head :ok }
    end
  end
end
