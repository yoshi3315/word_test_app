Rails.application.routes.draw do

  root 'users#index'

  resources :users, only: [:new, :create]
  get '/users', to: 'users#new'

end
