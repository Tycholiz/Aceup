Rails.application.routes.draw do


  # get 'employers/new'

  # get 'employers/create'

  # get 'seekers/new'

  # get 'seekers/create'

  # get 'sessions/new'

  # get 'sessions/create'

  # get 'users/new'

  # get 'users/create'

  resources :jobs

  resources :users, only: [:new, :create]

  resources :seekers, only: [:new, :create]

  resources :employers, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
