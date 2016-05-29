Rails.application.routes.draw do
  resources :targets
  resources :mobilizations
  resources :users

  get 'sessions/create'

  get 'sessions/destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  #static pages
  match '/sobre', to: 'static_pages#sobre', via: 'get'

  #mobilization
  match '/mobilizationnew', to: 'mobilizations#new', via: 'get'

  #user
  match 'usershow', to: 'user#show', via: 'get'


  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
