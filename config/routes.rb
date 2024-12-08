Rails.application.routes.draw do
  get "users/show"
  devise_for :users
  get 'users/profile', to: 'users#profile', as: :user_profile
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "posts#index"

  # Keep routes for posts, but exclude the 'new' route.
  resources :posts, except: [:new]  # Removed the 'new' action.
  resources :posts do
    member do
      post :like
      delete :unlike
    end
  end
end

