class WordsController < ApplicationController

  def index
    policy_scope(Word)
    @words = current_user.lists.first.words

    return if params[:entry].nil?

    @entry = translate_word(params[:entry])

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
