class QuizzQuestionsController < ApplicationController
  after_action :skip_authorization

  def question
    @list = List.find(params[:list_id])
    @word_list = @list.words_lists.where(quizz_status: nil).sample
    luck = (3..3).to_a.sample
    case luck
    when 1
      @question = 1
      @good_answer = @word_list.word.translation
      create_quizz_question(@word_list, 1, good_answer)
    when 2
      @question = 2
      @good_answer = @word_list.word.entry
      create_quizz_question(@word_list, 2, good_answer)
    when 3
      @question = 3
      @entry = @word_list.word.entry
      @quizz_good_answer = find_synonym(@word_list)
      @quizz_wrong_answers = Reference.where.not(synonyms: nil).sample(3).map { |i| i.synonyms.first }
      create_quizz_question(@word_list, 3, @quizz_good_answer, @quizz_wrong_answers)
    when 4
      @question = 4
      @entry = @word_list.word.entry
      @quizz_good_answer = find_definition(@word_list)
      @quizz_wrong_answers = Meaning.where.not(nou: nil).sample(3).map { |i| i.nou.first }
      create_quizz_question(@word_list, 4, @quizz_good_answer, @quizz_wrong_answers)
    when 5
      @question = 5
      @definition = find_definition(@word_list)
      @quizz_good_answer = @word_list.word.entry
      @quizz_wrong_answers = @list.words.reject { |i| i == @word_list.word }.sample(3).map(&:entry)
      create_quizz_question(@word_list, 5, @quizz_good_answer, @quizz_wrong_answers)
    end
  end

  def quizz_good_answer
    list = List.find(params[:list_id])
    word_list = WordsList.where(list: list, word: params[:word_id]).take
    word_list.update(quizz_status: true) # MEME QUAND ON CLIQUE SUR LA BONNE REPONSE IL MET LE STATUS EN FALSE PK ??
    raise
    redirect_to list_quizz_path(list)
  end

  def quizz_wrong_answer
    raise
    list = List.find(params[:list_id])
    word_list = WordsList.where(list: list, word: params[:word_id]).take
    word_list.update(quizz_status: false)
    raise
    redirect_to list_quizz_path(list)
  end

  private

  def create_quizz_question(word_list, type, good_answer, wrong_answers = nil)
    QuizzQuestion.create(
      words_list: word_list,
      question_type: type,
      good_answer: good_answer,
      wrong_answers: wrong_answers
    )
  end

  def find_definition(word_list)
    if !word_list.word.meaning.nou.nil?
      good_answer = word_list.word.meaning.nou.first
    elsif !word_list.word.meaning.vrb.nil?
      good_answer = word_list.word.meaning.vrb.first
    elsif !word_list.word.meaning.adj.nil?
      good_answer = word_list.word.meaning.adj.first
    else
      good_answer = word_list.word.meaning.adv.first
    end
  end

  def find_synonym(word_list)
    if !word_list.word.reference.synonyms.nil?
      good_answer = word_list.word.reference.synonyms.first
    elsif !word_list.word.reference.broad_terms.nil?
      good_answer = word_list.word.reference.broad_terms.first
    elsif !word_list.word.reference.related_terms.nil?
      good_answer = word_list.word.reference.related_terms.first
    else
      good_answer = word_list.word.reference.narrow_terms.first
    end
  end
end
