default_cms_actions = [:index, :new, :create, :edit, :update, :destroy]

Rails.application.routes.draw do
  namespace :cms, path: '', constraints: { subdomain: ['cms'] } do
    namespace :sessions, path: '' do
      post 'login'
      get 'logout'
      get 'forgot_password'
      get 'sign_up'
      post 'forgot_password'
      post 'sign_up'
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
