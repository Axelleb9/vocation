class UserWordsController < ApplicationController
  before_action :set_instances
  skip_after_action :verify_authorized

  def change_state_to_nou
    if params[:from].present?
      @word.update(state: "nou")
      redirect_to words_path(word_id: @word)
    else
      @user_word.update(state: "nou")
      respond_to do |format|
        format.html { redirect_to words_path }
        format.js
      end
    end
  end

  def change_state_to_adj
    if params[:from].present?
      @word.update(state: "adj")
      redirect_to words_path(word_id: @word)
    else
      @user_word.update(state: "adj")
      redirect_to words_path
    end
  end

  def change_state_to_vrb
    if params[:from].present?
      @word.update(state: "vrb")
      redirect_to words_path(word_id: @word)
    else
      @user_word.update(state: "vrb")
      respond_to do |format|
        format.html { redirect_to words_path }
        format.js
      end
    end
  end

  def change_state_to_adv
    if params[:from].present?
      @word.update(state: "adv")
      redirect_to words_path(word_id: @word)
    else
      @user_word.update(state: "adv")
      redirect_to words_path
    end
  end

  private

  def set_instances
    @word = Word.find(params["word_id"])
    @user_word = UserWord.where(user: current_user, word: @word).take
  end
end
