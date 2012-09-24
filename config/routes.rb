VolontariAt::Application.routes.draw do
  devise_for :users
  
  resources :pages, only: :index do
    collection do
      get :privacy_policy
      get :terms_of_use
      get :about_us
    end
  end
  
  resources :areas do
    resources :users, only: :index
    resources :projects, only: :index
    
    collection do
      put :update_multiple
    end
  end
  
  resources :products do
    resources :projects, only: [:index, :new]
    
    collection do
      put :update_multiple
    end
  end
  
  resources :projects do
    resources :users, only: :index
    resources :vacancies, only: [:index, :new]
    resources :stories, only: [:index, :new]
    resources :comments, only: [:index, :new]
    
    collection do
      put :update_multiple
    end
  end
      
  resources :vacancies do
    resources :candidatures, only: [:index, :new]
    resources :comments, only: [:index, :new]
    
    collection do
      put :update_multiple
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
    end
    
    member do
      get :accept
      get :deny
      get :quit
    end
  end
  
  resources :stories do
    resources :tasks, only: [:index, :new]
    
    collection do
      put :update_multiple
    end
  end
  
  resources :tasks do
    resources :results, only: [:index, :new]
    
    collection do
      put :update_multiple
    end
  end
  
  resources :results do
    collection do
      put :update_multiple
    end
  end
  
  resources :comments, only: [:new, :edit, :create, :update, :destroy]
  
  resources :users do
    resources :projects, only: :index
    resources :candidatures, only: :index
    
    collection do
      put :update_multiple
    end
  end
  
  match 'workflow' => 'workflow#index', as: :workflow
  
  namespace 'workflow' do
    resources :vacancies, controller: 'vacancies', only: :index do
      collection do
        match '/' => 'vacancies#open', as: :open
        
        get :open
        get :recommended
        get :denied
        get :closed
      end
    end
    
    resources :candidatures, controller: 'candidatures', only: :index do
      collection do
        match '/' => 'candidatures#new', as: :new
         
        get :new
        get :accepted
        get :denied
      end
    end
  end
  
  root to: 'home#index'
end
