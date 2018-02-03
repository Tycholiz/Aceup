Rails.application.routes.draw do
  namespace :admin do
    
    resources :jobs do
    	resources :applications do
      end
      resources :saved_jobs
      get 'activate', :on => :member  
    end

    resources :users, only: [:new, :create, :edit, :update, :index, :destroy]

    resources :seekers do
      resources :resumes, only: [:index, :new, :create, :destroy]
    	member do
    		get   :applied
        get   :saved_jobs
        get   :public
        get   :no_resume
    	end
    end

    resources :employers, only: [:new, :create, :index, :edit, :update, :destroy]  do
      member do
        get  :applications
      end
    end

    resources :dashboard, only: [:landing]
    root to: "/admin/dashboard#landing"


  end

  resources :jobs do
      resources :applications do
      end
      resources :saved_jobs
      get 'activate', :on => :member  
    end

    resources :users, only: [:new, :create, :edit, :update]

    resources :seekers do
      resources :resumes, only: [:index, :new, :create, :destroy]
      member do
        get   :applied
        get   :saved_jobs
        get   :public
        get   :no_resume
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
