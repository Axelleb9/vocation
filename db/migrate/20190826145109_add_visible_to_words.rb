class AddVisibleToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :visible, :boolean
  end
end
