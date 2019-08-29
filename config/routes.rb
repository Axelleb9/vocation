Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :words, only: [:new, :create, :delete, :index] do
    get "open_eye"
    get "close_eye"
    post "favori", to: "words#favori"
    delete "unfavori", to: "words#unfavori"
    post "add_to_list", to: "words#add_word_to_list"
  end

  resources :lists do
    put "order", to: 'words#change_order'
  end
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'study', to: 'pages#study', as: :study
  get 'study/flashcard', to: 'pages#flashcard'


end
