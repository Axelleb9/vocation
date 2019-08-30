class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized, only: [:flashcard, :wrong_answer, :good_answer]

  def index
    @lists = policy_scope(List)
    @list = List.new
  end

  def show
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
    @list = List.find(params[:list_id])
    @word = @list.words.sample
    # list.update(flashcard: @list.words.pluck(:entry)) if @list.flashcard.empty?
    # render :flashcard redirect_to request.referrer
  end

  def good_answer
    word = Word.find(params[:word_id])
    @list = List.find(params[:list_id])
    authorize @list
    @list.flashcard.delete(word.entry)
    @list.save
    redirect_to list_flashcard_path(@list)
  end

  def wrong_answer
    previous_word = params[:word_id]
    @list = List.find(params[:list_id])
    @word = @list.words.reject { |i| i == previous_word }.sample
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
