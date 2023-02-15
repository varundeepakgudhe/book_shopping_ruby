Rails.application.routes.draw do
  get 'admin_books/index'
  get 'admin_books/show'
  get 'admin_books/new'
  get 'admin_books/create'
  get 'admin_books/edit'
  get 'admin_books/update'
  get 'admin_books/destroy'
  # get 'admin_reviews/index'
  # get 'admin_reviews/new'
  # get 'admin_reviews/create'
  # get 'admin_reviews/edit'
  # get 'admin_reviews/update'
  # get 'admin_reviews/destroy'
  # get 'admin_reviews/show'
  # get 'admin/home'

  resources :books do
    resources :reviews
  end
  resources :transactions

  resources :admin_reviews, :path => "admin/reviews"

  resources :admin_users, :path => "admin/users"

  resources :admin_books, :path => "admin/book"

  # get 'admin/users', to: "admin_users#index", as: "admin_users"
  # post 'admin/users', to: "admin_users#create", as: "admin_create_users"
  # get 'admin/users/new', to: "admin_users#new", as: "admin_new_user"
  # get 'admin/users/:id', to: "admin_users#show", as: "admin_show_user"
  # get 'admin/users/:id/edit', to: "admin_users#edit", as: "admin_edit_user"
  # put 'admin/users/:id/update', to: "admin_users#update", as: "admin_update_user"
  # delete 'admin/users/:id', to: "admin_users#destroy", as: "admin_delete_user"
  get 'reviews/all', to: "reviews#index"
  get 'admin', to: "admin#home"
  get 'about', to: "about#index"
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root 'home#index'
end
