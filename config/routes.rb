Rails.application.routes.draw do
 
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'search_subject/:subject_id/:subject', to: 'search#subject', as:'search_subject'
    post 'answer', to: 'answer#question'
  end
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  namespace :admins_backoffice do
    get 'welcome/index' # Dashboard
    resources :admins # Administradores
    resources :subjects #Assuntos e areas
    resources :questions # Questões
  end

  
  devise_for :admins,skip: [:registrations]
  devise_for :users
 


  get 'inicio',to: 'site/welcome#index'

  
  root to: 'site/welcome#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
