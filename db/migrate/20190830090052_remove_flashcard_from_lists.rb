class RemoveFlashcardFromLists < ActiveRecord::Migration[5.2]
  def change
    remove_column :lists, :flashcard, :string
  end
end
