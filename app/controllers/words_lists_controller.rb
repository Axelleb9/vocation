class WordsListsController < ApplicationController
  def new
  	@word = Word.find(params[:word_id])
  	authorize @word
  end
end