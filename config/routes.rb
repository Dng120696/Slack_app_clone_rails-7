Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :channels do
    resources :messages, only: [:create]
    post 'add_users', on: :member
  end
  mount ActionCable.server, at: '/cable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
