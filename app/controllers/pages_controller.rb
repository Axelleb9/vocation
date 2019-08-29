class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def study
  end

  def flashcard
    @lists = current_user.lists
    @flashcards = []
    @lists.each do |list|
    @flashcards << list.flashcards
    end
    @flashcards.flatten

  end


end
