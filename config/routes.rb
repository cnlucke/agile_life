Rails.application.routes.draw do
  namespace :groups do
    get 'tasks/index'
  end

  namespace :groups do
    get 'tasks/show'
  end

  resource :session, only: [:new, :create, :destroy]
  resource :user
  resources :tasks
  resources :events

  resources :groups do
    scope module: :groups do
      resources :tasks, only: [:index, :show]
      resources :events, only: [:index, :show]
    end
  end
end
