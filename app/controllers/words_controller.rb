class WordsController < ApplicationController
    skip_after_action :verify_authorized, only: [:change_order, :create]

  def index
    policy_scope(Word)
    @list = current_user.lists.first
    @word = Word.new

    @current_word = Word.find(params[:word_id]) if params[:word_id].present?
  end

  def create
    word = Word.find_by(entry: params_word[:entry])
    if word.nil?
      translation = translate_word(params_word[:entry])
      word = Word.new(
        entry: params_word[:entry],
        translation: translation
      )
      word.save
      FetchExampleJob.perform_later(translation, current_user.id, word.id)
      FetchDifficultyJob.perform_later(translation, current_user.id, word.id)
      FetchDefinitionJob.perform_later(translation, current_user.id, word.id)
      FetchSynonymsJob.perform_later(translation, current_user.id, word.id)
    end
    redirect_to words_path(word_id: word.id)
  end

  def change_order
    @list = List.find(params[:list_id])
    @list.order ? @list.update(order: false) : @list.update(order: true)
    redirect_to words_path
  end

  def open_eye
    @word = Word.find(params[:word_id])
    @word.liked_by current_user
    authorize @word
    redirect_to words_path
  end

  def close_eye
    @word = Word.find(params[:word_id])
    @word.downvote_from current_user
    authorize @word
    redirect_to words_path
  end

  private

  def params_word
    params.require(:word).permit(:entry)
  end
  def translate_word(word)
    base = "https://translate.yandex.net/api/v1.5/tr.json/translate?"
    key = ENV["YANKEY"]
    languages = "fr-en"
    url = "#{base}lang=#{languages}&key=#{key}&text=#{word}"
    callback = JSON.parse(HTTP.get(url))
    callback["text"].first
  end
end
