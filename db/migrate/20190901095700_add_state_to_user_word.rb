class AddStateToUserWord < ActiveRecord::Migration[5.2]
  def change
    add_column :user_words, :state, :string
  end
end
