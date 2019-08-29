class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @lists = policy_scope(List.where(user_id: current_user.id))

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
    @list = List.find(params[:list_id])
    authorize @list
    @list.update(flashcard: @list.words.pluck(:entry)) if @list.flashcard.empty?
    render :flashcard
  end

  def good_answer
    @list = List.find(params[:list_id])
    authorize @list
    @list.flashcard.shift
    @list.save
    render :flashcard
  end

  def wrong_answer
    @list = List.find(params[:list_id])
    authorize @list
    @list.flashcard.sample
    render :flashcard
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
