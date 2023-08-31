Rails.application.routes.draw do

    devise_for :users
    root to: "movies#index"

    resources :movies do
      collection do
        get :search
        get :ranking
      end
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
    
    resources :tags, only: [:show], param: :name
    resources :categories, only: [:index]
    resources :users, only: [:show]
end