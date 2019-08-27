class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @lists = policy_scope(List)
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
    @list = current_user.lists.new(list_params)
    authorize @list

    if @list.save
      redirect_to @list
    else
      render :new
    end
  end

  def update
    @list.update(list_params)
    if @list.save

      redirect_to @list
    else
      render :edit
    end
  end

  def destroy
    authorize @list
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :description, :user_id)
  end

  def set_list
    @list = List.find(params[:id])
    authorize @list
  end
end
