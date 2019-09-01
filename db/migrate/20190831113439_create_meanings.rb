class CreateMeanings < ActiveRecord::Migration[5.2]
  def change
    create_table :meanings do |t|
      t.references :word, foreign_key: true
      t.string :nou, array: true
      t.string :vrb, array: true
      t.string :adj, array: true
      t.string :adv, array: true

      t.timestamps
    end
  end
end
