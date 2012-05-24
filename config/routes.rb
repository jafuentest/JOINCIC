Sistema::Application.routes.draw do

  root :to => "home#inicio"

  match "/iniciarSesion", :to => "sessions#new"
  match "/cerrarSesion",  :to => "sessions#destroy"
  match "/login",         :to => "sessions#new"
  match "/logout",        :to => "sessions#destroy"
  match "/reportes",      :to => "home#reportes"
  match "/academico",     :to => "home#academico"
  match "/patrocinio",    :to => "home#patrocinio"

  get "sessions/new"
  get "home/inicio"
  get "home/academico"
  get "home/patrocinio"
  get "home/reportes"

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
      get  "buscar"
      get  "universidades"
      get  "reiniciarComidas"
      get  "infoComidas"
      get  "entregarComida"
      post "entregarComida"
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

  resources :participantes_mates, :only => [:new] do
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

  resources :rifas do
    collection do
      post "getParticipants"
      post "setWinner"
    end
  end
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :organizadores
  resources :materiales_pop
  resources :premios
  resources :planes
  resources :patrocinantes
  resources :ponencias
  resources :ponentes
  resources :zonas
end
