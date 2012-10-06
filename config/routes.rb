Volontariat::Application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'devise_extensions/registrations',
  }
  
  resources :pages, only: :index do
    collection do
      get :privacy_policy
      get :terms_of_use
      get :about_us
      get :autocomplete
    end
  end
  
  resources :areas do
    resources :users, only: :index
    resources :projects, only: :index
    
    collection do
      put :update_multiple
      get :autocomplete
    end
  end
  
  resources :professions do
    collection do
      put :update_multiple
      get :autocomplete
    end
  end
  
  resources :products do
    resources :projects, only: [:index, :new]
    
    collection do
      put :update_multiple
      get :autocomplete
    end
  end
  
  resources :projects do
    resources :users, only: :index
    resources :vacancies, only: [:index, :new]
    resources :stories, only: [:index, :new]
    resources :comments, only: [:index, :new]
    
    collection do
      put :update_multiple
      get :autocomplete
    end
  end
      
  resources :vacancies do
    resources :candidatures, only: [:index, :new]
    resources :comments, only: [:index, :new]
    
    collection do
      put :update_multiple
      get :autocomplete
    end
    
    member do
      get :recommend
      get :accept_recommendation
      get :deny_recommendation 
      get :close
      get :reopen
    end
  end
  
  resources :candidatures do
    resources :comments, only: [:index, :new]
    
    collection do
      put :update_multiple
      get :autocomplete
    end
    
    member do
      get :accept
      get :deny
      get :quit
    end
  end
  
  resources :stories, only: [:create, :show, :edit, :update, :destroy] do
    resources :tasks, only: [:index, :new]
    
    collection do
      put :update_multiple
      get :autocomplete
    end
    
    member do
      match 'setup_tasks' => 'stories#setup_tasks', via: [:get, :put]
      match 'activate' => 'stories#activate', via: [:get, :put]
    end
  end
  
  resources :tasks do
    resources :results, only: [:index, :new]
    
    collection do
      put :update_multiple
      get :autocomplete
    end
  end
  
  resources :results do
    collection do
      put :update_multiple
      get :autocomplete
    end
  end
  
  resources :comments, only: [:new, :edit, :create, :update, :destroy]
  
  resources :users do
    resources :projects, only: :index
    resources :candidatures, only: :index
    
    collection do
      put :update_multiple
      get :autocomplete
    end
    
    member do
      match 'preferences', via: [:get, :put]
    end
  end
  
  match 'workflow' => 'workflow#index', as: :workflow
  
  namespace 'workflow' do
    resources :project_owners, only: :index do
    end

    resources :users, only: :index do
    end
    
    resources :vacancies, controller: 'vacancies', only: :index do
      collection do
        match '/' => 'vacancies#open', as: :open
        
        get :autocomplete
        
        get :open
        get :recommended
        get :denied
        get :closed
      end
    end
    
    resources :candidatures, controller: 'candidatures', only: :index do
      collection do
        match '/' => 'candidatures#new', as: :new
         
        get :autocomplete 
         
        get :new
        get :accepted
        get :denied
      end
    end
  end
  
  require 'sidekiq/web'; mount Sidekiq::Web, at: '/sidekiq'
  
  root to: 'home#index'
end
