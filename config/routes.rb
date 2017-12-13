Rails.application.routes.draw do
	
  get 'sessions/new'

  get 'sessions/create'

  get 'users/new'

  get 'users/create'

  resources :jobs

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
