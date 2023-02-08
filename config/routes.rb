Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  get 'about', to: "about#index"
  get 'home', to: "home#index"
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
