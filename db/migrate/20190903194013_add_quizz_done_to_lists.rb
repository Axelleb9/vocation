class AddQuizzDoneToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :quizz_done, :boolean, default: false
  end
end
