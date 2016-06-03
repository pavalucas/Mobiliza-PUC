Rails.application.routes.draw do
  resources :targets
  resources :mobilizations do
    member do
      put 'press', to: 'mobilizations#press'
    end
  end
  resources :users

  get 'sessions/create'

  get 'sessions/destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'mobilizations#index'

  #static pages
  match '/sobre', to: 'static_pages#sobre', via: 'get'
  #match 'busca-por-categoria/:id/' => 'mobilizations#showByCategory', via: 'get'
  match 'busca-por-categoria/:id' => 'mobilizations#showByCategory', via: 'get'


  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
