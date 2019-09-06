class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def study
  end

  def flashcards
    @flashcards = current_user.lists.where(week: nil)
    @flashcards_weeks = current_user.lists.where.not(week: nil)
    @list_of_the_week = List.where(title: "List of the week").take
  end

  def quizzes
    @user_lists = current_user.lists.where(week: nil, quizz_done: false)
    @list_of_the_week = List.where(title: "List of the week").take
  end

  def results
  end
end
