Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resource :user
  resources :tasks
  resources :events
  resources :groups

  root 'static#index'
end
