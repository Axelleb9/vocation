class Word < ApplicationRecord
  has_many :words_lists
  has_many :user_words
  has_many :users, through: :user_words
  validates :entry, :translation, presence: true
  has_many :lists, through: :words_lists
  acts_as_votable
end
