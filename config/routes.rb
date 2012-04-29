Sistema::Application.routes.draw do

  root :to => "home#inicio"

  match "/iniciarSesion",         :to => "sessions#new"
  match "/cerrarSesion",          :to => "sessions#destroy"
  match "/login",                 :to => "sessions#new"
  match "/logout",                :to => "sessions#destroy"
  
  get "sessions/new"
  get "home/inicio"
  get "home/academico"
  get "home/patrocinio"
  
  resources :participantes do
    collection do
      get  "reporte"
      get  "buscar"
      get  "reiniciarComidas"
      get  "entregarComida"
      post "entregarComida"
    end
  end
  
  resources :mesas_de_trabajo do
    member do
      post "sortear"
      post "reiniciar"
    end
  end
  
  resources :participantes_mates, :only => [:index, :show, :new] do
    collection do
      get  "buscar"
      post "crear"
      post "entregar"
    end
  end
  
  resources :participantes_mesas, :only => [:index, :show, :new] do
    collection do
      get  "buscar"
      post "crear"
    end
  end
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :organizadores
  resources :materiales_pop
  resources :premios
  resources :planes
  resources :patrocinantes
  resources :preguntas
  resources :ponencias
  resources :ponentes
  resources :rifas
  resources :zonas
end