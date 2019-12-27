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

  #get 'tags/:tag', to: "tasks#index", as: :tags

  #PAGE
  root 'pages#index'

  #ADMIN
  namespace :admin, path: 'admin' do
    resources :users
    get 'sign_up', to: 'users#new'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end

end
