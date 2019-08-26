class CreateWordsLists < ActiveRecord::Migration[5.2]
  def change
    create_table :words_lists do |t|
      t.references :word, foreign_key: true
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
