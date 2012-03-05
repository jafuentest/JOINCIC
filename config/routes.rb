Sistema::Application.routes.draw do

  get "admin/login"

  get "admin/logout"

  get "admin/index"

  get "organizadores/login"

  get "comidas/inicio"

  get "comidas/entrega"
  
  get "participantes/reiniciarComidas"

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

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
