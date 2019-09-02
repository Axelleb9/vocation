class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def study
  end

  def flashcards
    @flashcards = current_user.lists.where(week: nil)
    @flashcards_weeks = current_user.lists.where.not(week: nil)
  end

  def quizzes
  end
end
