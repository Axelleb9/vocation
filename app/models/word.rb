class Word < ApplicationRecord
  has_many :users, through: :user_words
  validates :entry, :translation, presence: true
end
