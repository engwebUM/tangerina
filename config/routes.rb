Rails.application.routes.draw do

  get '', to: 'home#index', as: '/'

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
  end

  resources :favorites

  resources :subscriptions
  resources :contents
  resources :articles do
    resources :comments
    resources :favorites

    member do
      get :create_review
      patch :create_review
    end
    collection do
      post :create_review
      match 'search' => 'articles#search', via: [:get, :post], as: :search
    end

  end

  resources :themes

  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, controller: 'users', only: [:create, :index, :show] do
    resource :password,
      controller: 'clearance/passwords',
      only: [:index, :show, :create, :edit, :update]
  end

  #get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  # delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  #get 'sign_up',  to: 'clearance/users#new'

  get 'tags/:tag', to: 'articles#index', as: :tag

  #resources :articles

  root to: 'articles#index'

  resources :reviews do
    member do
      get :reject
      get :accept
    end
  end

  get '/advanced_search' => 'articles#advanced_search'

end
