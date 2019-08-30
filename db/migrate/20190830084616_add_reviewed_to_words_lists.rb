class AddReviewedToWordsLists < ActiveRecord::Migration[5.2]
  def change
    add_column :words_lists, :reviewed, :boolean, default: false
  end
end
