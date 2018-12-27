Rails.application.routes.draw do

  root 'users#index'

  resources :users, only: [:new, :create]

  get  '/login',   to: 'application#login'
  post '/login',   to: 'application#login'
  delete '/logout', to: 'application#logout'

  match '*path' => 'application#error404', via: :all
end
