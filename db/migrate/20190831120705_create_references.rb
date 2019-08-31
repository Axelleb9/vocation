class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.references :word, foreign_key: true
      t.string :broad_terms, array: true
      t.string :narrow_terms, array: true
      t.string :related_terms, array: true
      t.string :synonyms, array: true

      t.timestamps
    end
  end
end
