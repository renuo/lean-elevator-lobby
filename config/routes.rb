Rails.application.routes.draw do
  resources :teams do
    get 'logs', on: :member
  end
  devise_for :users

  get 'stats/overall'
  get 'stats/rounds'
  get 'stats/simulator'

  root 'pages#index'
end
