class QuizzQuestion < ApplicationRecord
  belongs_to :words_list, optional: true
end
