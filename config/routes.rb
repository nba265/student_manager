# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  # get 'students/index'
  root 'user/students#index'
  # root to: "home#index"
  namespace :front do
    resources :login
  end

  namespace :user do
    resources :students do
      get 'media', on: :member
    end

    resources :medias
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
