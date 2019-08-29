class AddWeekToList < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :week, :integer
  end
end
