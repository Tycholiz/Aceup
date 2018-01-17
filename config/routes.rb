Rails.application.routes.draw do

  resources :jobs do
  	resources :applications
    resources :saved_jobs
  end

  resources :users, only: [:new, :create]

  resources :seekers do
    resources :resumes, only: [:index, :new, :create]
  	member do
  		get  :applied
      get  :saved_jobs
      get  :public
  	end
  end

  resources :employers do #, only: [:new, :create, :show, :edit]
    member do
      get  :applications
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :messages, only: [:new, :create]

  get "/pages/:page" => "pages#show"


  root to: "pages#landing"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
