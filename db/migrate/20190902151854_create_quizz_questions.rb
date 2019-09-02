class CreateQuizzQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :quizz_questions do |t|
      t.references :words_list, foreign_key: true
      t.string :good_answer
      t.string :wrong_answers, array: true
      t.integer :question_type

      t.timestamps
    end
  end
end
