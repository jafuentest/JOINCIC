class SessionsController < ApplicationController
  skip_before_filter :organizadorLogin

  def new
    @title = 'Iniciar Sesion'
  end

  def create
    organizador = Organizador.comprobarOrganizador(params[:session][:usuario], params[:session][:clave])
    if (!organizador)
      if Organizador.find_by_usuario(params[:session][:usuario]).nil?
        flash.now[:notice] = 'El usuario no existe'
      else
        flash.now[:notice] = 'La clave y el nombre de usuario no coinciden'
      end
      @title = 'Iniciar Sesion'
      render 'new'
    else
      session[:usuario_id]  = organizador.id
      session[:privilegios] = 'organizador'
      session[:organizador] = organizador.nombreCompleto
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
