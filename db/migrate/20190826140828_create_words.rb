class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :entry
      t.string :translation
      t.text :definition
      t.text :example
      t.string :nature
      t.integer :difficulty
      t.string :synonyms, array: true

      t.timestamps
    end
  end
end
