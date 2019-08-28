Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :words, only: [:new, :create, :delete, :index]
  resources :lists do
    put "order", to: 'words#change_order'
  end
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
