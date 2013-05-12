class ApplicationController < ActionController::Base
  before_filter :estarLogueado
  
  def estarLogueado
    if session[:organizador].nil?
      flash[:notice] = "Debe iniciar sesion para poder acceder al sistema"
      redirect_to new_session_path
    end
  end
  
  protect_from_forgery
end