Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end


  get "followed_posts", to: "posts#followed_posts", as: :followed_posts

  root "posts#index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "/posts/new", to: "posts#new", as: :new_post

  resources :posts do
    member do
      post :same_mood
      delete :undo_same_mood
    end
    collection do
      get :search_gif
    end
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get "edit_avatar",   to: "users#edit_avatar",   as: :edit_avatar
      patch "update_avatar", to: "users#update_avatar", as: :update_avatar
      get "edit_handle",   to: "users#edit_handle",   as: :edit_handle
      patch "update_handle", to: "users#update_handle", as: :update_handle
      post "follow"
      delete "unfollow"
      get "unfollow",      to: "users#unfollow"
    end

    collection do
      get "profile"
    end
  end
end
