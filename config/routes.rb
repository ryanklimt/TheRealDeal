UnknownBusiness::Application.routes.draw do
  
  root 'static_pages#home'
  
  get 'home', to: "static_pages#home", as: 'home'
  get 'help', to: "static_pages#help", as: 'help'
  get 'about', to: "static_pages#about", as: "about"
  get 'contact', to: "static_pages#contact", as: 'contact'
  
  resources :users, only: [:index] do
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :wallposts, only: [:create, :destroy]
  
  resources :forums do
    resources :subforums, shallow: true
  end
  resources :subforums do
    resources :topics, shallow: true
  end
  resources :topics do
    resources :posts, shallow: true
  end
  resources :sessions, only: [:new, :create, :destroy]
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  delete 'logout', to: "sessions#destroy", as: 'logout'
  get 'settings', to:'users#edit', as: 'settings'
  
  match "/:username" => "users#show", via: "get"
  match "/:username" => "users#update", via: "patch"
  match "/:username" => "users#destroy", via: "delete"
  match "/:username/following" => "users#following", via: "get"
  match "/:username/followers" => "users#followers", via: "get"
  match '*path' => redirect('/'), via: :get
  resources :users, :path => '/'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
