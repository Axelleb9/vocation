class WordsController < ApplicationController
  skip_after_action :verify_authorized, only: [:change_order, :create, :favori, :unfavori, :add_word_to_list]
  before_action :create_list_of_the_week, only: [:index, :favori, :unfavori]

  def index
    policy_scope(Word)
    @word = Word.new
    @lists = current_user.lists
    @current_word = Word.find(params[:word_id]) if params[:word_id].present?
  end

  def create
    word = Word.find_by(entry: params_word[:entry])
    if word.nil?
      entry = params_word[:entry]
      word = Word.new(entry: entry)
      word.save
      FetchTranslationJob.perform_now(entry, current_user.id, word.id)
      FetchExampleJob.perform_now(entry, current_user.id, word.id)
      FetchDifficultyJob.perform_now(entry, current_user.id, word.id)
      FetchDefinitionJob.perform_now(entry, current_user.id, word.id)
      FetchSynonymsJob.perform_now(entry, current_user.id, word.id)
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

  def favori
    current_word = Word.find(params[:word_id])
    user_word = UserWord.new(user: current_user, word: current_word)
    user_word.save
    WordsList.create(word: current_word, list: @list)
    redirect_to words_path(word_id: current_word.id)
  end

  def unfavori
    @current_word = Word.find(params[:word_id])
    user_word = UserWord.where(word: @current_word, user: current_user).take
    WordsList.where(word: @current_word, list: @list).take.destroy
    user_word.destroy
    redirect_to words_path(word_id: @current_word.id)
  end

  def add_word_to_list
    word = Word.find(params[:word_id])
    list = List.find(params[:list_id])
    words_list = WordsList.new(word: word, list: list)
    words_list.save
    redirect_to words_path(word_id: word.id)
  end

  private

  def params_word
    params.require(:word).permit(:entry)
  end

  def create_list_of_the_week
    current_week = Date.today.cweek - 1
    @list = current_user.lists.where(week: current_week).take
    return unless @list.blank?
    @list = List.create(title: "week #{current_week}", user: current_user, week: current_week)
  end
end
