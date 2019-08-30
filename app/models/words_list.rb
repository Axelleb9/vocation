class WordsList < ApplicationRecord
  belongs_to :word
  belongs_to :list

  def self.default_scope
    WordsList.order(created_at: :desc)
  end
end
