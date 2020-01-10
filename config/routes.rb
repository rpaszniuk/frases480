default_cms_actions = [:index, :new, :create, :edit, :update, :destroy]

Rails.application.routes.draw do
  namespace :api, path: '', constraints: { subdomain: ['api'] }, defaults: { format: :json } do
    namespace :v1 do
      resources :phrases, only: [:index, :show]
      resources :categories, only: [:index, :show]
      namespace :users do
        post 'sign-in'
        post '', action: :create, as: :create
      end
      namespace :me do
        get '', action: :show, as: :show
        put '', action: :update, as: :update
        resources :phrases, only: [:index, :create, :show, :destroy, :update]
      end
    end
  end

  namespace :cms, path: '', constraints: { subdomain: ['cms'] } do
    namespace :sessions, path: '' do
      post 'login'
      get 'logout'
      get 'forgot_password'
      get 'sign_up'
      post 'forgot_password'
      post 'sign_up'
      get '/recover_password/:secure_hash', action: :recover_password, as: :recover_password
      patch 'change_password'
    end

    namespace :dashboard do
      get :index, as: '/'
    end

    resources :users, only: default_cms_actions
    resources :access_profiles, only: default_cms_actions
    resources :phrases, only: default_cms_actions
    resources :categories, only: default_cms_actions

    namespace :me do
      get '', action: :show, as: :show
    end

    namespace :login do
      get '', action: :index, as: :index
    end

    get '/', action: :index, controller: :login, as: :root
  end

  namespace :web, path: '', constraints: { subdomain: ['', 'www'] } do
    namespace :main, path: '' do
      get :acerca, action: :about
      get :feed
      # get :sitemap
    end

    resources :phrases, only: [:show, :index]
    resources :categories, only: [:show, :index]
    get 'search/:action' => 'searches#:action'
    get '/:id', controller: :categories, action: :show, as: :show_category
    get '/:id/:phrase', controller: :phrases, action: :show, as: :show_phrase
    get '/', action: :index, controller: :main, as: :root
  end
end
