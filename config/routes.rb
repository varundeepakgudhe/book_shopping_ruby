Rails.application.routes.draw do

  resources :books do
    resources :reviews
  end
  resources :transactions

  get 'admin/users', to: "users#index", as: "users"
  post 'admin/users', to: "users#create", as: "create_users"
  get 'admin/users/new', to: "users#new", as: "new_user"
  get 'admin/users/:id', to: "users#show", as: "show_user"
  get 'admin/users/:id/edit', to: "users#edit", as: "edit_user"
  put 'admin/users/:id/update', to: "users#update", as: "update_user"
  delete 'admin/users/:id', to: "users#destroy", as: "delete_user"

  get 'about', to: "about#index"
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root 'books#index'
end
