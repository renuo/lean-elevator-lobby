Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  get 'dashboard', to: 'dashboard#index', as: :user_root

  scope 'admin' do
    get 'game/index'
    post 'game/start'
    post 'game/stop'

    resources :teams do
      get 'logs', on: :member
    end
  end

  resource :myteam, controller: :my_team do
    post 'join', on: :member
    post 'leave', on: :member
  end
  
  get 'stats/overall'
  get 'stats/rounds'
  get 'stats/simulator'
end
