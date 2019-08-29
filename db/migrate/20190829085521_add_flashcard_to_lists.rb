class AddFlashcardToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :flashcard, :string, array: true
  end
end
