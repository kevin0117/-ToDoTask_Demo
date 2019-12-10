Rails.application.routes.draw do
  resources :tasks
  
  get 'sign_up', to: 'users#new'
  # post 'users', to: 'users#create'
  resources :users, except: [:new]
  root 'tasks#index'
end
