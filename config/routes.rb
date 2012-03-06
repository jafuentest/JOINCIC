Sistema::Application.routes.draw do

  get "home/academico"

  get "home/inicio"

  get "home/patrocinio"
  
  resources :planes_de_patrocinio

  resources :patrocinantes
  
  resources :sorteos

  resources :premios

  resources :rifas

  resources :preguntas

  resources :ponencias

  resources :ponentes

  resources :materiales_pop

  resources :mesas_de_trabajo

  resources :organizadores

  resources :participantes

  resources :participantes_mates

  resources :participantes_mesas

  resources :zonas
  
  match '/entregaDeMaterial', :to => 'participantes_mates#new'
	
	match '/inscripcionMesas', :to => 'participantes_mesas#new'
  
  match '/organizadores/validar', :to => 'organizadores#validar'
	
	match '/inicio', :to => 'home#inicio'
  
  match '/comidas', :to => 'comidas#inicio'
  
  match '/participantes/comida', :to => 'participantes#comida'
	
	root :to => 'home#inicio'
end
