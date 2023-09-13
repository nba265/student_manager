# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'students/index'

  root 'front/login#index'

  namespace :front do
    resources :login
  end

  namespace :user do
    resources :students
    resources :medias
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
