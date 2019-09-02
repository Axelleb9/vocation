class AddQuizzStatusToWordsLists < ActiveRecord::Migration[5.2]
  def change
    add_column :words_lists, :quizz_status, :boolean, default: false
  end
end
