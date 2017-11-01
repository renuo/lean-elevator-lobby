Rails.application.routes.draw do
  resources :teams

  root 'pages#index'
end
