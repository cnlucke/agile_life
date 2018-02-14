Rails.application.routes.draw do
  root 'application#index'
  resource :session, only: [:new, :create, :destroy]
  resource :user
  resources :tasks
  resources :events
  resources :groups

end
