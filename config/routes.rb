Rails.application.routes.draw do
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create, :new, :create, :new]
      resources :likes, only: [:create]
    end
  end
end
