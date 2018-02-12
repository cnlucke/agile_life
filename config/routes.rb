Rails.application.routes.draw do
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  resources :users do
    resources :tasks
    resources :events
  end
  resources :groups do
    resources :tasks, only: [:index, :show]
    resources :events, only: [:index, :show]
  end
end
