# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords'
  }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  namespace :admins do
    resources :dashboard
  end

  namespace :front do
    resources :home
  end

  namespace :customers do
    resources :dashboard
    resources :students do
      member do
        get 'media'
      end
      collection do
        get 'deleted'
      end
    end

    resources :customers

    # resources :medias
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
