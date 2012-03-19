class SessionsController < ApplicationController
  skip_before_filter :estarLogueado, :only => [:new, :create]
  
  def new
	@title = "Iniciar Sesion"
  end
  
  def create
	organizador = Organizador.comprobarOrganizador(params[:session][:usuario],
				  params[:session][:clave])
	if (!organizador)
		flash.now[:notice] = "Ha introducido mal el nombre de usuario o clave"
		@title = "Iniciar Sesion"
		render 'new'
	else
		session[:organizador] = organizador.usuario
		/Pagina a donde se quiera ir/
		redirect_to inicio_path
	end
  end
  
  def destroy
	/@_current_user = session[:organizador] = nil/
	reset_session
	redirect_to inicioSesion_path
  end

end
