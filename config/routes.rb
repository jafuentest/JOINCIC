Sistema::Application.routes.draw do
  
  root :to => "home#inicio"
  
  match "/ologin",      :to => "sessions#new"
  match "/ologout",     :to => "sessions#destroy"
  match "/glogin",      :to => "group_sessions#new"
  match "/glogout",     :to => "group_sessions#destroy"
  match "/perfil",      :to => "grupos#perfil"
  match "/maraton",     :to => "grupos#perfil"
  match "/reportes",    :to => "home#reportes"
  match "/academico",   :to => "home#academico"
  match "/patrocinio",  :to => "home#patrocinio"
  
  get "sessions/new"
  get "home/inicio"
  get "home/academico"
  get "home/patrocinio"
  get "home/reportes"
  
  match "/preguntar",          :to => "preguntas#new"
  match "/enviarPregunta",     :to => "preguntas#new"
  match "/enviarpregunta",     :to => "preguntas#new"
  match "/preguntarAlPonente", :to => "preguntas#new"
  match "/preguntaralponente", :to => "preguntas#new"
  match "/preguntas/ver/:id",  :to => "preguntas#show", :as => :ver_pregunta
  match "/preguntas/ponencia/:ponencia_id(.:format)", :to => "preguntas#index"
  match "/panel-preguntas(/:ponencia_id)", :to => "preguntas#panel", :as => :panel_preguntas
  
  resources :participantes do
    collection do
      get  "xml"
      get  "excel"
      get  "excelPatrocinantes"
      get  "controlDeVentas"
      get  "buscar"
      get  "universidades"
      get  "reiniciarComidas"
      get  "infoComidas"
      get  "enviarCorreoATodos"
      get  "entregarComida"
      post "entregarComida"
      get  "enviarCorreo"
      post "enviarCorreo"
    end
  end
  
  resources :preguntas, :only => [:index, :show, :new, :create] do
    member do
      get "aprobar"
    end
    collection do
      get "dame_preguntas"
    end
  end
  
  resources :mesas_de_trabajo do
    member do
      post "sortear"
      post "reiniciar"
      post "excel"
    end
  end
  
  resources :participantes_mates, :only => [:new, :create] do
    collection do
      get  "buscar"
      post "entregar"
    end
  end
  
  resources :participantes_mesas, :only => [:new, :create, :show, :destroy] do
    collection do
      get  "buscar"
    end
  end
  
  resources :rifas do
    collection do
      get "rifar"
      get "getParticipantes"
      post "getParticipantes"
      post "setWinner"
    end
  end
  
  resources :grupos do
    collection do
      get "perfil"
    end
    member do
      get "reiniciarClave"
    end
  end
  
  resources :problemas do
    member do
      get "descargarEntrada"
      get "descargarSalida"
    end
  end
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :group_sessions, :only => [:new, :create, :destroy]
  resources :sugerencias, :except => [:edit, :update]
  resources :organizadores
  resources :materiales_pop
  resources :premios
  resources :planes
  resources :patrocinantes
  resources :ponencias
  resources :ponentes
  resources :zonas
  
  match '*a', :to => 'errors#routing'
end
