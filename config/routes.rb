Rails.application.routes.draw do
  resources :teams
  devise_for :users

  get 'pages/stats'

  root 'pages#index'
end
