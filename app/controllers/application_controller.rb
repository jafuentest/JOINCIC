class ApplicationController < ActionController::Base
   before_filter :estarLogueado
  
  def estarLogueado
    if(session[:organizador] == nil)
      #flash[:notice] = "Debes estar logueado para poder hacer cualquier cambio"
      redirect_to new_session_path
    end
  end 
  protect_from_forgery
end
