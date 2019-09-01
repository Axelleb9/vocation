class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :entry
      t.string :translation
      t.text :definition, array: true
      t.text :example, array: true
      t.string :nature, array: true
      t.integer :difficulty
      t.string :synonyms, array: true

      t.timestamps
    end
  end
end
