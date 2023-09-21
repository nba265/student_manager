# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
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

  root to: 'customers/students#index'

  namespace :customers do
    resources :courses do
      collection do
        get :get_teachers
      end
    end
    resources :teachers
    resources :dashboard
    resources :birthdays
    resources :students do
      member do
        get 'media'
        put 'restore'
      end
      collection do
        get 'reload_student_table'
        put 'swap_positions'
        get 'reload_current_page'
      end
    end
    resources :customers

    # resources :medias
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
