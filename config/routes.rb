Rails.application.routes.draw do


  resources :jobs do
  	resources :applications
  end

  resources :users, only: [:new, :create]

  resources :seekers do
  	member do
  		get  :applied
  	end
  end

  resources :employers #, only: [:new, :create, :show, :edit]

  resources :sessions, only: [:new, :create, :destroy]

  get "/pages/:page" => "pages#show"


  root to: "sessions#new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
