TutorBear::Application.routes.draw do
  root to: 'pages#index'

  get '/admin' => redirect('/en/admin')

  get '/r/:path' => 'pages#redirect'
  get '/i/:name' => 'pages#image'

  scope ":locale", locale: /en|ru/  do
    ActiveAdmin.routes(self)

    root to: 'pages#index'

    devise_for :admin_users, ActiveAdmin::Devise.config
    devise_for :users, skip: :sessions, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

    post '/add_cmt' => 'posts#add_cmt', as: :add_cmt

    resources :posts

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
  end

end
