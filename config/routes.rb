Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :words, only: [:new, :create, :delete, :index] do
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
    patch "quizz_good_answer", to: 'quizz_questions#quizz_good_answer'
    patch "quizz_wrong_answer", to: 'quizz_questions#quizz_wrong_answer'
    patch "quizz_define_result", to: 'quizz_questions#quizz_define_result'
    get "quizz", to: "quizz_questions#question"

  end
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'study', to: 'pages#study', as: :study
  get 'study/flashcards', to: 'pages#flashcards'
  get 'study/quizzes', to: 'pages#quizzes'

  mount ActionCable.server => "/cable"

  get "/lists/:list_id/words/:word_id/open_eye", to: 'words#open_eye', as: :open_eye
  get "/lists/:list_id/words/:word_id/close_eye", to: 'words#close_eye', as: :close_eye

end
