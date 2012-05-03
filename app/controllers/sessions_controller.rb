class SessionsController < ApplicationController
  skip_before_filter :estarLogueado, :only => [:new, :create]
  layout "login"
  
  def new
    @title = "Iniciar Sesion"
  end
  
  def create
    organizador = Organizador.comprobarOrganizador(params[:session][:usuario],
            params[:session][:clave])
    if (!organizador)
      flash.now[:notice] = "Error: La contraseña y el nombre de usuario no coinciden"
      @title = "Iniciar Sesion"
      render "new"
    else
      session[:organizador] = organizador.nombreCompleto
      redirect_to root_path
    end
  end
  
  def destroy
    /@_current_user = session[:organizador] = nil/
    reset_session
    redirect_to root_path
  end
end
