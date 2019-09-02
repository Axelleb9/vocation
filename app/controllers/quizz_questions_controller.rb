class QuizzQuestionsController < ApplicationController

  def question
    list = List.find(params[:list_id])
    word = list.words_lists.where(quizz_status: false).sample
    word.update(quizz_status: true)
    luck = (1..5).to_a.sample
    case luck
    when 1
    when 2
    when 3
    when 4
    when 5
    end
  end

end
