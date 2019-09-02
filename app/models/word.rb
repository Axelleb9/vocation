class Word < ApplicationRecord
  has_many :words_lists
  has_many :user_words
  has_many :users, through: :user_words
  has_many :lists, through: :words_lists
  has_one :meaning
  has_one :reference
  acts_as_votable
end
