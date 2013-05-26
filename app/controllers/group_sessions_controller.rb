class GroupSessionsController < ApplicationController
  skip_before_filter :organizadorLogin
  
  def new
    @title = "Iniciar Sesion"
  end

  def create
    grupo = Grupo.comprobarGrupo(params[:session][:login], params[:session][:clave])
    if (!grupo)
      if Grupo.find_by_login(params[:session][:login]).nil?
        flash.now[:notice] = "Login incorrecto, revise el login ingresado e intente de nuevo.<br/>Si el problema persiste por favor diríjase a la mesa de registro".html_safe
      else
        flash.now[:notice] = "Contraseña incorrecta, intente nuevamente.<br/>Si el problema persiste por favor diríjase a la mesa de registro".html_safe
      end
      @title = "Iniciar Sesion"
      render :new
    else
      session[:usuario_id]  = grupo.id.to_s
      session[:privilegios] = "grupo"
      redirect_to perfil_path
    end
  end

  def destroy
    /@_current_user = session[:organizador] = nil/
    /@_current_user = session[:id] = nil/
    reset_session
    redirect_to new_grupo_path
  end
end
