Rails.application.routes.draw do
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/signup', to: 'users#new'
  resources :users, except: [:new] do
    resources :tasks
    resources :events
  end
  resources :groups do
    resources :tasks, only: [:index, :show]
    resources :events, only: [:index, :show]
  end
end
