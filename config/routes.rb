Rails.application.routes.draw do
  resources :tasks do
    collection  do
      get :user
    end
  end
  #SESSION
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #USER
  get 'sign_up', to: 'users#new'
  resources :users, except: [:new]

  #TASK
  # root 'tasks#index'

  #PAGE
  root 'pages#index'

  #ADMIN
  namespace :admin, path: 'mhw' do
    resources :users
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    # resources :tasks
  end

end
