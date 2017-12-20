Rails.application.routes.draw do

  resources :jobs

  resources :users, only: [:new, :create]

  resources :seekers, only: [:new, :create]

  resources :employers, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]

  root to: "sessions#new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
