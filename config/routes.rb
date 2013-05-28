Sistema::Application.routes.draw do
  
  root :to => 'home#inicio'
  get 'sessions/new'
  get 'home/inicio'
  get 'home/academico'
  get 'home/patrocinio'
  get 'home/reportes'
  
  resources :materiales_pop, :organizadores, :patrocinantes, :planes, :ponencias, :ponentes, :premios, :zonas
  resources :sessions,       :only => [:new, :create, :destroy]
  resources :group_sessions, :only => [:new, :create, :destroy]
  resources :sugerencias,    :except => [:edit, :update]
  
  resources :grupos, :except => [:edit, :update] do
    get 'perfil',         :on => :collection
    get 'reiniciarClave', :on => :member
  end
  
  resources :mesas_de_trabajo do
    member do
      post 'sortear'
      post 'reiniciar'
      post 'excel'
    end
  end
  
  resources :participantes do
    collection do
      get  'xml'
      get  'excel'
      get  'excelPatrocinantes'
      get  'controlDeVentas'
      get  'buscar'
      get  'universidades'
      get  'reiniciarComidas'
      get  'infoComidas'
      get  'enviarCorreoATodos'
      get  'entregarComida'
      post 'entregarComida'
      get  'enviarCorreo'
    end
  end
  
  resources :participantes_mates, :only => [:new, :create] do
    collection do
      get  'buscar'
      post 'entregar'
    end
  end
  
  resources :participantes_mesas, :only => [:new, :create, :show, :destroy] do
    get 'buscar', :on => :collection
  end
  
  resources :preguntas, :except => [:edit, :update] do
    get 'aprobar',        :on => :member
    get 'dame_preguntas', :on => :collection
  end
  
  resources :programas, :except => [:edit, :update] do
    get 'serve', :on => :member
  end
  
  resources :rifas do
    collection do
      get  'rifar'
      get  'getParticipantes'
      post 'getParticipantes'
      post 'setWinner'
    end
  end
  
  match '*a', :to => 'errors#routing'
  match '/ologin',      :to => 'sessions#new'
  match '/ologout',     :to => 'sessions#destroy'
  match '/glogin',      :to => 'group_sessions#new'
  match '/glogout',     :to => 'group_sessions#destroy'
  match '/perfil',      :to => 'grupos#perfil'
  match '/maraton',     :to => 'grupos#perfil'
  match '/reportes',    :to => 'home#reportes'
  match '/academico',   :to => 'home#academico'
  match '/patrocinio',  :to => 'home#patrocinio'
  #Sub-Sistema de Preguntas
  match '/preguntar',          :to => 'preguntas#new'
  match '/enviarPregunta',     :to => 'preguntas#new'
  match '/enviarpregunta',     :to => 'preguntas#new'
  match '/preguntarAlPonente', :to => 'preguntas#new'
  match '/preguntaralponente', :to => 'preguntas#new'
  match '/preguntas/ver/:id',  :to => 'preguntas#show', :as => :ver_pregunta
  match '/preguntas/ponencia/:ponencia_id(.:format)', :to => 'preguntas#index'
  match '/panel-preguntas(/:ponencia_id)', :to => 'preguntas#panel', :as => :panel_preguntas
end
