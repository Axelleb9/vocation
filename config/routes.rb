Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :words, only: [:new, :create, :delete, :index]
  resources :lists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
