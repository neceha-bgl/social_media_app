require 'api_constraints'
SocialMediaApp::Application.routes.draw do

  use_doorkeeper
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      match 'user', to: 'users#show'
    end

    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: true) do
      match 'user', to: 'users#show'
    end
  end

  resources :omniauth_accounts
  match "/accounts" =>  "omniauth_accounts#accounts"
  match "/accounts/:provider" =>  "omniauth_accounts#account", :as => :account

  get "omniauth_callbacks/create"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  resources :users
  match "/user/account" => "users#view"

  resources :venues
  match 'contact' => 'contact#new', as: 'contact', via: 'get'
  match 'contact' => 'contact#create', as: 'contact', via: 'post'
  
  resources :pages, except: :show
  get ':id', to: 'pages#show', as: :page
  put ':id', to: 'pages#update', as: :page
  delete ':id', to: 'pages#destroy', as: :page


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
