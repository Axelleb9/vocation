class AddOrderToList < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :order, :boolean, default: true
  end
end
