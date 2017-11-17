Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users
  get 'dashboard', to: 'dashboard#index', as: :user_root

  resources :teams do
    get 'logs', on: :member
    post 'join', on: :member
  end

  get 'stats/overall'
  get 'stats/rounds'
  get 'stats/simulator'
end
