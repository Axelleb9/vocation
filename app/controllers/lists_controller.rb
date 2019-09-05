
class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:index, :flashcard, :wrong_answer, :good_answer]

  def index
    policy_scope(List)
    if params["lists"].nil?
      @lists = current_user.lists.select { |i| i.week.nil? }
    else
      @lists = current_user.lists.where.not(week: nil)
    end
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = current_user.lists.new
    authorize @list
  end

  def edit
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    authorize @list

    if @list.save
      redirect_to lists_path
    else
      render :index
    end
  end

  def update
    @list.update(list_params)
    if @list.save

      redirect_to lists_path
    else
      render :index
    end
  end

  def destroy
    authorize @list
    @list.destroy
    redirect_to lists_path
  end

  def flashcard
    # word = Word.find(params[:word_id])
    @list = List.find(params[:list_id])
    @word_false = @list.words_lists.reject { |i| i.reviewed == true }
    @word = @word_false.sample
    @total_number = @list.words.count
    @learning = @list.words_lists.where(reviewed: false).count
    @mastered = @word_false.count
    @list.update(flashcard_done: true) if @word_false.empty?
  end

  def good_answer
    word = Word.find(params[:word_id])
    @list = List.find(params[:list_id])
    authorize @list
    word_status = word.words_lists.find_by(list_id: @list.id)
    word_status.reviewed = true
    word_status.save
    redirect_to list_flashcard_path(@list)
  end

  def wrong_answer
    word = Word.find(params[:word_id])
    @list = List.find(params[:list_id])
    authorize @list
    word_status = word.words_lists.find_by(list_id: @list.id)
    word_status.reviewed = false
    word_status.save
    redirect_to list_flashcard_path(@list)
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

  def set_list
    @list = List.find(params[:id])
    authorize @list
  end
end
