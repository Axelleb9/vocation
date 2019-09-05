class WordsList < ApplicationRecord
  belongs_to :word
  belongs_to :list
  has_one :quizz_question, dependent: :nullify

  def self.default_scope
    WordsList.order(created_at: :desc)
  end
end
