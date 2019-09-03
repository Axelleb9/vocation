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
<<<<<<< HEAD
    raise
=======
    @quizzes = current_user.lists.where(week: nil)
>>>>>>> 74deeb9da8f9b67a2f32e3f40050c9cca2ad9b77
  end
end
