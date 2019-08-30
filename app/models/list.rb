class List < ApplicationRecord
  belongs_to :user
  has_many :words_lists, dependent: :destroy
  has_many :words, through: :words_lists


  validates :title, presence: true
end
