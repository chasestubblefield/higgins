require 'resque/server'

Higgins::Application.routes.draw do

  resources :builds, only: [:index, :show, :create] do
    member do
      get 'enqueue'
    end
  end

  resources :jobs, only: [] do
    member do
      get 'enqueue'
    end
  end

  resources :workers, only: [:index]

  scope via: :get do
    root to: 'home#index'

    namespace :auth do
      match 'login'
      match 'logout'
      match 'callback'
    end
  end

  mount Resque::Server, at: '/resque'

end
