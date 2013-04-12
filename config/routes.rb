TutorBear::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, skip: :sessions, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  match 'users/sign_in' => redirect('/')
  match 'users/sign_out' => 'users#logout', as: :logout
  match 'users/register' => 'users#register', as: :register
  match 'users/login' => 'users#login', as: :login

  devise_scope :user do
    get '/users/auth/:provider/callback' => 'users/omniauth_callbacks#passthru'

    get 'profile/edit' => 'users#edit', as: :edit_profile
    put 'profile/update' => 'users#update', as: :update_profile
    match 'profile/balance(/:status)' => 'balance#index', as: :profile_balance, via: [:get, :post]
    post 'profile/robokassa' => 'balance#robokassa', as: :robokassa

    post '/send_contacts' => 'contacts#send_contacts', as: :send_contacts
  end

  get 'profile/(:id)' => 'users#show', as: :show_profile

  match 'process_payment' => 'balance#process_payment'

  match '/search' => 'search#index', as: :search
  match '/search/get_count' => 'search#get_count'

  post '/send_feedback' => 'feedbacks#send_feedback', as: :send_feedback

  get 'languages/match_names' => 'languages#match_names', as: :match_languages
  
  root to: 'pages#index'

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
