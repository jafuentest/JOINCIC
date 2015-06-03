class ApplicationController < ActionController::Base
  before_filter :organizadorLogin
  
  def organizadorLogin
    if session[:usuario_id].nil?
      flash[:notice] = "Debe iniciar sesión para poder acceder al sistema"
      redirect_to new_session_path
    elsif session[:privilegios] != "organizador"
      flash[:notice] = "La página que intentó acceder, solo está disponible para el personal organizador del evento"
      redirect_to perfil_path
    end
  end
  
  def grupoLogin
    if session[:usuario_id].nil? || (session[:privilegios] != "grupo" && session[:privilegios] != "organizador")
      flash[:notice] = "Debe registrarse para poder acceder al sistema"
      redirect_to new_grupo_path
    end
  end
  
  def participanteLogin
    if session[:usuario].nil? || session[:privilegios] < PARTICIPANTE
      flash[:notice] = "Debe iniciar sesión para poder acceder al sistema"
      redirect_to new_session_path
    end
  end
  
  protect_from_forgery
end
