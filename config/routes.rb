Rails.application.routes.draw do

  resources :subscriptions

  resources :articles do
    resources :comments
  end

resources :themes

  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, controller: 'users', only: [:create] do
    resource :password,
      controller: 'clearance/passwords',
      only: [:index, :show, :create, :edit, :update]
  end

  #get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  # delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  #get 'sign_up',  to: 'clearance/users#new'

  #get 'home/index'
  get 'tags/:tag', to: 'articles#index', as: :tag

  #resources :articles

  root to: 'articles#index'


  resources :reviews do
    member do
      get :reject
    end
  end


<<<<<<< HEAD
=======

>>>>>>> subscriptions
  get '/advanced_search' => 'articles#advanced_search'


  # constraints Clearance::Constraints::SignedIn.new do
  #   root to: 'home#index', as: :signed_in_root
  # end

#  constraints Clearance::Constraints::SignedOut.new do
#     root to: 'articles#index'
#   end




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
