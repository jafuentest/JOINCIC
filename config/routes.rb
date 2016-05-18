Rails.application.routes.draw do
  root to: 'home#inicio'

  get 'sessions/new'
  get 'home/inicio'
  get 'home/academico'
  get 'home/patrocinio'
  get 'home/reportes'

  resources :materiales_pop, :organizadores, :patrocinantes, :planes, :ponencias, :ponentes, :premios, :zonas
  resources :sessions,       only: [:new, :create, :destroy]
  resources :group_sessions, only: [:new, :create, :destroy]
  resources :sugerencias,    except: [:edit, :update]

  resources :grupos, except: [:edit, :update] do
    get 'perfil',         on: :collection
    get 'reiniciarClave', on: :member
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
      get  'validarCedula'
    end
  end

  resources :participantes_mates, only: [:new, :create] do
    collection do
      get  'buscar'
      post 'entregar'
    end
  end

  resources :participantes_mesas, only: [:new, :create, :show, :destroy] do
    get 'buscar', on: :collection
  end

  resources :preguntas, except: [:edit, :update] do
    get 'aprobar',        on: :member
    get 'dame_preguntas', on: :collection
  end

  resources :problemas do
    member do
      get 'descargarEntrada'
      get 'descargarSalida'
    end
  end

  resources :programas, except: [:edit, :update] do
    get 'serve', on: :member
    get 'serve_privado', on: :member
    collection do
      get 'listar'
      get 'validar'
    end
  end

  resources :rifas do
    collection do
      get  'rifar'
      get  'getParticipantes'
      post 'getParticipantes'
      post 'setWinner'
    end
  end

  get    '/academico'  => 'home#academico'
  get    '/patrocinio' => 'home#patrocinio'
  get    '/reportes'   => 'home#reportes'
  get    '/maraton'    => 'grupos#perfil'
  get    '/glogin'     => 'group_sessions#new'
  delete '/glogout'    => 'group_sessions#destroy'
  get    '/ologin'     => 'sessions#new'
  delete '/ologout'    => 'sessions#destroy'

  #Sub-Sistema de Preguntas
  get '/preguntar' => 'preguntas#new'
  get '/preguntas/ponencia/:ponencia_id(.:format)' => 'preguntas#index'
  get '/panel-preguntas(/:ponencia_id)' => 'preguntas#panel', as: :panel_preguntas

  get '*a' => 'errors#routing'
end
