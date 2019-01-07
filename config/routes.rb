Rails.application.routes.draw do

  root 'questions#main'

  resources :users, only: [:new, :create]

  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :questions

  match '*path' => 'application#error404', via: :all
end
