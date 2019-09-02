class QuizzQuestionsController < ApplicationController
  after_action :skip_authorization
  def question
    @list = List.find(params[:list_id])
    @word = @list.words_lists.where(quizz_status: false).sample
    @word.update(quizz_status: true)
    luck = (1..5).to_a.sample
    case luck
    when 1
      @question = 1
    when 2
      @question = 2
    when 3
      @question = 3
    when 4
      @question = 4
    when 5
      @question = 5
    end
  end
end
