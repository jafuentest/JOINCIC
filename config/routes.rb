Sistema::Application.routes.draw do
  
	root :to => 'home#inicio'
  
	match '/inicio', :to => 'home#inicio'  
  
  get "home/inicio"
  
  get "home/academico"
  
  get "home/patrocinio"
  
  resources :organizadores
  
  resources :participantes do
    collection do
      get  "reiniciarComidas"
      get  "buscar"
      get  "comidas"
      post "comidas"
    end
  end
  
  resources :participantes_mates do
    post "crear", :on => :collection
  end
  
  resources :participantes_mesas
  
  resources :materiales_pop
  
  resources :mesas_de_trabajo
  
  resources :premios
  
  resources :planes
  
  resources :patrocinantes
  
  resources :preguntas
  
  resources :ponencias
  
  resources :ponentes
  
  resources :rifas
  
  resources :zonas
end