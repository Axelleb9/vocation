class WordsList < ApplicationRecord
  belongs_to :word
  belongs_to :list
end
