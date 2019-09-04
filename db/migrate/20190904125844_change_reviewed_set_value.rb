class ChangeReviewedSetValue < ActiveRecord::Migration[5.2]
  def change
    change_column :words_lists, :reviewed, :boolean, default: nil
  end
end
