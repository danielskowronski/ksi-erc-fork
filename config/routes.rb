Rails.application.routes.draw do
  resources :tshirt_issues
  resources :tshirt_definitions
  resources :book_keep_records
  resources :book_keep_categories
  resources :book_leases
  delete '/book_leases/:id/return', to: 'book_leases#return', as: :return_book_lease
  resources :books
  resources :publishing_houses
  resources :authors
  get 'lock/authorize'

  get '/ksiegozbior', to: 'books#ksiegozbior', as: :ksiegozbior
  get '/members/generate_mailing', to: 'members#generate_mailing', as: :generate_mailing
  get '/memberships/filter/:id(/:exportable)', to: 'memberships#show_filtered', as: :memberships_show_filtered
  get '/memberships-stats', to: 'memberships#stats', as: :memberships_stats
  get '/book_keep_records/filter/:id', to: 'book_keep_records#filter', as: :book_keep_record_filter

  resources :memberships
  resources :comments
  resources :periods
  resources :roles
  resources :members
  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new', as: :login
  delete '/logout', to: 'sessions#destroy', as: :logout
  resources :members
  resources :roles
  resources :periods
  resources :memberships

  get '/authorize', to: 'lock#authorize', as: :authorize

  get '/unused', to: 'pages#unused', as: :unused
  get '/advanced', to: 'pages#advanced', as: :advanced
  get '/enroll', to: 'pages#enroll', as: :new_enroll
  post '/enroll', to: 'pages#enroll', as: :new_enroll_post
  get '/members-admin', to: 'pages#members_admin', as: :new_members
  get '/tshirts-admin', to: 'pages#tshirts_admin', as: :new_tshirts
  get '/definitions', to: 'pages#definitions', as: :new_definitions
  get '/lock', to: 'pages#lock', as: :new_lock
  get '/config', to: 'pages#configure', as: :new_config
  post '/config', to: 'pages#configure', as: :new_config_post

  root 'pages#index'
end
