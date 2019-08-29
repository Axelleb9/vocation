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
      entry = params_word[:entry]
      word = Word.new(entry: entry)
      word.save
      FetchTranslationJob.perform_later(entry, current_user.id, word.id)
      FetchExampleJob.perform_later(entry, current_user.id, word.id)
      FetchDifficultyJob.perform_later(entry, current_user.id, word.id)
      FetchDefinitionJob.perform_later(entry, current_user.id, word.id)
      FetchSynonymsJob.perform_later(entry, current_user.id, word.id)
    end
    redirect_to words_path(word_id: word.id)
  end

  def change_order
    @list = List.find(params[:list_id])
    @list.switch ? @list.update(switch: false) : @list.update(switch: true)
    redirect_to(request.referer)
  end

  def open_eye
    @word = Word.find(params[:word_id])
    @word.liked_by current_user
    authorize @word
    redirect_to(request.referer)
  end

  def close_eye
    @word = Word.find(params[:word_id])
    @word.downvote_from current_user
    authorize @word
    redirect_to(request.referer)
  end

  private

  def params_word
    params.require(:word).permit(:entry)
  end
end
