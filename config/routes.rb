Rails.application.routes.draw do
  ### advanced mode

  # tshirts
  resources :tshirt_issues
  resources :tshirt_definitions

  # library
  resources :book_keep_records
  resources :book_keep_categories
  resources :book_leases
  delete '/book_leases/:id/return', to: 'book_leases#return', as: :return_book_lease
  resources :books
  resources :publishing_houses
  resources :authors
  get '/ksiegozbior', to: 'books#ksiegozbior', as: :ksiegozbior
  get '/book_keep_records/filter/:id', to: 'book_keep_records#filter', as: :book_keep_record_filter

  # members-memberships
  resources :memberships
  resources :comments
  resources :periods
  resources :roles
  resources :members
  get '/members/generate_mailing', to: 'members#generate_mailing', as: :generate_mailing
  get '/memberships/filter/:id(/:exportable)', to: 'memberships#show_filtered', as: :memberships_show_filtered
  get '/memberships-stats', to: 'memberships#stats', as: :memberships_stats
  resources :members
  resources :roles
  resources :periods
  resources :memberships

  # static pages
  get '/unused', to: 'pages#unused', as: :unused
  get '/advanced', to: 'pages#advanced', as: :advanced

  ### special purpose
  get 'lock/authorize'
  get '/authorize', to: 'lock#authorize', as: :authorize
  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new', as: :login
  delete '/logout', to: 'sessions#destroy', as: :logout



  ### new mode

  # static pages
  get '/definitions', to: 'pages#definitions', as: :new_definitions

  # system
  get '/config', to: 'pages#configure', as: :new_config
  post '/config', to: 'pages#configure', as: :new_config_post

  # entrollment wizards
  get '/enroll', to: 'enroll#enroll', as: :new_enroll
  post '/enroll', to: 'enroll#enroll', as: :new_enroll_post
  get '/enroll/tshirt', to: 'enroll#tshirt', as: :new_enroll_tshirt
  post '/enroll/tshirt', to: 'enroll#tshirt', as: :new_enroll_tshirt_post
  get '/enroll/fee', to: 'enroll#fee', as: :new_enroll_fee
  post '/enroll/fee', to: 'enroll#fee', as: :new_enroll_fee_post
  get '/enroll/lock', to: 'enroll#lock', as: :new_enroll_lock
  post '/enroll/lock', to: 'enroll#lock', as: :new_enroll_lock_post

  # TODO: members-admin controller
  get '/members-admin(/:mode)', to: 'pages#members_admin', as: :new_members
  get '/members-admin/show/:id', to: 'pages#members_admin_show', as: :new_members_show

  ### master
  root 'pages#index'
end
