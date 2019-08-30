class RenameListsorderToSwitch < ActiveRecord::Migration[5.2]
  def change
    rename_column :lists, :order, :switch
  end
end
