class AddFlashcardDoneToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :flashcard_done, :boolean
  end
end
