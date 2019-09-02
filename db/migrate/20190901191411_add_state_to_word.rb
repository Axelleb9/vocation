class AddStateToWord < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :state, :string
  end
end
