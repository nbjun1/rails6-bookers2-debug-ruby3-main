Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users


  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    resource :relationships, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

end