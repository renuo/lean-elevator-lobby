Rails.application.routes.draw do
  resources :teams
  devise_for :users

  root 'pages#index'
end
