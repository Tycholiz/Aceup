Rails.application.routes.draw do


  get 'resumes/create'

  get 'resumes/new'

  resources :jobs do
  	resources :applications
  end

  resources :users, only: [:new, :create]

  resources :seekers do
    resources :resumes, only: [:index, :new, :create]
  	member do
  		get  :applied
  	end
  end

  resources :employers do #, only: [:new, :create, :show, :edit]
    member do
      get  :applications
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get "/pages/:page" => "pages#show"


  root to: "sessions#new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
