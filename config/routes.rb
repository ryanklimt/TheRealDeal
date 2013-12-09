UnknownBusiness::Application.routes.draw do
  
  root 'static_pages#home'
  
  get 'home', to: 'static_pages#home', as: 'home'
  get 'help', to: 'static_pages#help', as: 'help'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'contact', to: 'static_pages#contact', as: 'contact'
  
  resources :users, only: [:index, :create, :new]
  
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
  get 'settings', to: 'users#edit', as: 'settings'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  
  get 'threads', to: "forums#index", as: 'threads'
  
  match '/:username' => 'users#show', via: 'get'
  match '/:username' => 'users#admin', via: 'put'
  match '/:username' => 'users#update', via: 'patch'
  match '/:username' => 'users#destroy', via: 'delete'
  match '/:username/following' => 'users#following', via: 'get'
  match '/:username/followers' => 'users#followers', via: 'get'
  resources :users, :path => '/', only: [:show]
  
  match '*path' => redirect('/'), via: :get

end
