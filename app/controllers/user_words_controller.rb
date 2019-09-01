class UserWordsController < ApplicationController
  before_action :set_instances
  skip_after_action :verify_authorized

  def change_state_to_nou
    @user_word.update(state: "nou")
    redirect_to words_path
  end

  def change_state_to_adj
    @user_word.update(state: "adj")
    redirect_to words_path
  end

  def change_state_to_vrb
    @user_word.update(state: "vrb")
    redirect_to words_path
  end

  def change_state_to_adv
    @user_word.update(state: "adv")
    redirect_to words_path
  end

  private

  def set_instances
    @word = Word.find(params["word_id"])
    @user_word = UserWord.where(user: current_user, word: @word).take
  end
end
