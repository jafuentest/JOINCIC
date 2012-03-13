Sistema::Application.routes.draw do
  
	root :to => 'home#inicio'

	match '/inicio', :to => 'home#inicio'
	
  match '/participantes/buscar', :to => 'participantes#buscar'
  
  match '/participantes/comidas', :to => 'participantes#comidas'
  
  match '/participantes/reiniciarComidas', :to => 'participantes#reiniciarComidas'
  
  match '/participantes_mates/create', :to => 'participantes_mates#create'

  get "home/inicio"

  get "home/academico"

  get "home/patrocinio"
  
  resources :premios

  resources :rifas

  resources :planes
  
  resources :patrocinantes
  
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
end
