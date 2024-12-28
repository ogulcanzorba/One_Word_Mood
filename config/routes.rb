Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  get "followed_posts", to: "posts#followed_posts"
  root "posts#index"
  get "up" => "rails/health#show"
  get "service-worker" => "rails/pwa#service_worker"
  get "manifest" => "rails/pwa#manifest"
  resources :users do
    member do
      get "edit_avatar"
      patch "update_avatar"
      get "edit_handle"
      patch "update_handle"
      post "follow"
      delete "unfollow"
      get "unfollow"
    end
    collection do
      get "profile"
    end
  end
  resources :posts do
    member do
      post :same_mood
      delete :undo_same_mood
    end
    collection do
      get :search_gif
    end
  end
end
