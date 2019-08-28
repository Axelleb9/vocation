class WordsController < ApplicationController
    skip_after_action :verify_authorized, only: [:change_order]

  def index
    policy_scope(Word)
    @list = current_user.lists.first
    @word = Word.new
  end

  def create
    @entry = translate_word(params[:word][:entry])
    authorize @entry
    # TwinwordJob.perform_later(@entry)
    regex = /(^.*$)/
    base = "https://twinword-word-graph-dictionary.p.rapidapi.com/"
    infos = ["example/?", "difficulty/?", "definition/?", "reference/?"]


    infos.each_with_index do |info, index|
      url = "#{base + info}entry=#{@entry}"
      callback = HTTP.get(url, headers: headers)
      response = JSON.parse(callback)
      case index
      when 0 then @example = response['example'].first
      when 1 then @difficulty = response["ten_degree"]
      when 2 then
        definitions = response["meaning"].reject { |_k, v| v == "" } # clean les key vides
        @meanings = definitions.map { |_k, v| regex.match(v)[1] }
      when 3 then @synonyms = response["relation"]["broad_terms"].split(',').first(3)
      end
    end
  end

  def change_order
    @list = List.find(params[:list_id])
    @list.order ? @list.update(order: false) : @list.update(order: true)
    redirect_to words_path
  end

  private

  def translate_word(word)
    base = "https://translate.yandex.net/api/v1.5/tr.json/translate?"
    key = ENV["YANKEY"]
    languages = "fr-en"
    url = "#{base}lang=#{languages}&key=#{key}&text=#{word}"
    callback = JSON.parse(HTTP.get(url))
    callback["text"].first
  end
end
