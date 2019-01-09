Rails.application.routes.draw do

  root 'questions#main'

  resources :users, only: [:new, :create]

  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :questions, except: [:show]
  
  get '/tango_tests', to: 'tango_tests#index'
  post '/tango_tests', to: 'tango_tests#check'

  match '*path' => 'application#error404', via: :all
end
