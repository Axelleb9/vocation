class WordsController < ApplicationController
  skip_after_action :verify_authorized, only: [:change_order, :create, :favori, :unfavori, :add_word_to_list]
  before_action :create_list_of_the_week, only: [:index, :favori, :unfavori]

  def index
    policy_scope(Word)
    @word = Word.new
    @lists = current_user.lists
    @new_word = Word.find(params[:new_word_id]) if params[:new_word_id].present?
    @current_word = Word.find(params[:word_id]) if params[:word_id].present?
  end

  def create
    word = Word.find_by(entry: params_word[:entry].downcase)
    if word.nil?
      entry = params_word[:entry].downcase
      word = Word.new(entry: entry)
      word.save
      FetchTranslationJob.perform_later(entry, current_user.id, word.id)
      FetchExampleJob.perform_later(entry, current_user.id, word.id)
      FetchDifficultyJob.perform_later(entry, current_user.id, word.id)
      FetchDefinitionJob.perform_later(entry, current_user.id, word.id)
      FetchSynonymsJob.perform_later(entry, current_user.id, word.id)
      redirect_to words_path(new_word_id: word.id)
    else
      redirect_to words_path(word_id: word.id)
    end
  end

  def change_order
    @list = List.find(params[:list_id])
    @list.switch ? @list.update(switch: false) : @list.update(switch: true)
    redirect_to(request.referer)
  end

  def open_eye
    @word = Word.find(params[:word_id])
    @list = List.find(params[:list_id])
    @word.liked_by current_user
    authorize @word
    respond_to do |format|
      format.html { redirect_to(request.referer) }
      format.js
    end
  end

  def close_eye
    @word = Word.find(params[:word_id])
    @list = List.find(params[:list_id])
    @word.downvote_from current_user
    authorize @word
    respond_to do |format|
      format.html { redirect_to(request.referer) }
      format.js
    end
  end

  def favori
    current_word = Word.find(params[:word_id])
    user_word = UserWord.new(user: current_user, word: current_word, state: set_state(current_word))
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
    week_list = List.where(title: "List of the week").take
    week_word_list = WordsList.new(word: word, list: week_list)
    week_word_list.save
    user_word = UserWord.new(word: word, user: current_user, state: set_state(word))
    user_word.save
    words_list = WordsList.new(word_id: word.id, list_id: list.id)
    words_list.save
    redirect_to words_path(word_id: word.id)
  end

  private

  def params_word
    params.require(:word).permit(:entry)
  end

  def create_list_of_the_week
    current_week = Date.today.cweek

    @list = current_user.lists.where(week: current_week).take
    return unless @list.blank?
    @list = List.create(title: "week #{current_week}", user: current_user, week: current_week)
  end

  def set_state(word)
    if !word.meaning.nou.blank?
      "nou"
    elsif !word.meaning.adj.blank?
      "adj"
    elsif !word.meaning.vrb.blank?
      "vrb"
    elsif !word.meaning.adv.blank?
      "adv"
    end
  end
end
