UnknownBusiness::Application.routes.draw do
  
  root 'static_pages#home'
  
  get 'home', to: 'static_pages#home', as: 'home'
  get 'help', to: 'static_pages#help', as: 'help'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'contact', to: 'static_pages#contact', as: 'contact'
   
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
  
  # Session Routes
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  # User Routes
  resources :users, only: [:index, :create]
  get 'verify/:email_auth_token', to: 'users#verify', as: 'verify'
  get 'signup', to: 'users#new', as: 'signup'
  get 'settings', to: 'users#edit'
  get ':username', to: "users#show", as: :user
  patch ':username', to: "users#update"
  delete ':username', to: "users#destroy"
  put ':username', to: "users#admin", as: :admin
  get ':username/following', to: "users#following", as: :following
  get ':username/followers', to: "users#followers", as: :followers
  
  match '*path' => redirect('/'), via: :get

end
