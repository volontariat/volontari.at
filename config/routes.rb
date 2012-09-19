VolontariAt::Application.routes.draw do
  devise_for :users
  
  resources :areas do
    resources :users
    resources :projects
    
    collection do
      put :update_multiple
    end
  end
  
  resources :projects do
    resources :users
    resources :vacancies
    resources :comments
    
    collection do
      put :update_multiple
    end
  end
      
  resources :vacancies do
    resources :candidatures
    resources :comments
    
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
    resources :comments
    
    collection do
      put :update_multiple
    end
    
    member do
      get :accept
      get :deny
      get :quit
    end
  end
  
  resources :comments, only: [:new, :edit, :create, :update, :destroy]
  
  resources :users do
    resources :projects
    resources :candidatures
    
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
