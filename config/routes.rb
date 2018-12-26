Rails.application.routes.draw do

  root 'users#index'

  resources :users, only: [:new, :create]

  match '*path' => 'application#error404', via: :all
end
