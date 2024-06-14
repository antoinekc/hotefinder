Rails.application.routes.draw do
  get 'team', to: 'pages#team'
  get 'about', to: 'pages#about'
  resources :welcome, only: [:index]
  resources :missions

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Ajoutez une route pour l'index des utilisateurs
  resources :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
   root "welcome#index"
end
