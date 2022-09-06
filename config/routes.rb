Rails.application.routes.draw do
  resource :user do
    resources :transactional, only: [:new, :create]
  end
  match "/user/transactional" => "transactional#create", :via => :post, :as => :create_user_transaction
  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'
  match "*path" => "welcome#index", via: [:get, :post]
end
