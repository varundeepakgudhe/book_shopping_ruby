Rails.application.routes.draw do
  get 'admin/home'

  resources :books do
    resources :reviews
  end
  resources :transactions

  get 'admin/users', to: "admin_users#index", as: "admin_users"
  post 'admin/users', to: "admin_users#create", as: "admin_create_users"
  get 'admin/users/new', to: "admin_users#new", as: "admin_new_user"
  get 'admin/users/:id', to: "admin_users#show", as: "admin_show_user"
  get 'admin/users/:id/edit', to: "admin_users#edit", as: "admin_edit_user"
  put 'admin/users/:id/update', to: "admin_users#update", as: "admin_update_user"
  delete 'admin/users/:id', to: "admin_users#destroy", as: "admin_delete_user"

  get 'admin', to: "admin#home"
  get 'about', to: "about#index"
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root 'books#index'
end
