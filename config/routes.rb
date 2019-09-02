Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :words, only: [:new, :create, :delete, :index] do
    get "open_eye"
    get "close_eye"
    post "change_state_to_nou", to: "user_words#change_state_to_nou"
    post "change_state_to_vrb", to: "user_words#change_state_to_vrb"
    post "change_state_to_adj", to: "user_words#change_state_to_adj"
    post "change_state_to_adv", to: "user_words#change_state_to_adv"
    post "favori", to: "words#favori"
    delete "unfavori", to: "words#unfavori"
    post "add_to_list", to: "words#add_word_to_list"

    resources :words_lists, only: [:new]
  end

  resources :lists do
    put "order", to: 'words#change_order'
    get "flashcard", to: 'lists#flashcard'
    patch "good_answer", to: 'lists#good_answer'
  end
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'study', to: 'pages#study', as: :study
  get 'study/flashcards', to: 'pages#flashcards'

  mount ActionCable.server => "/cable"
end
