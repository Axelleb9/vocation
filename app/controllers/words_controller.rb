class WordsController < ApplicationController

  def index
    policy_scope(Word)

    unless params[:entry].nil?

      host = "twinword-word-graph-dictionary.p.rapidapi.com"
      twin_key = ENV["TWINKEY"]
      project_id = ENV["PROJECTID"]
      regex = /(^.*$)/
      base = "https://twinword-word-graph-dictionary.p.rapidapi.com/"
      info = ["example/?", "difficulty/?", "definition/?", "reference/?"]
      headers = {
        "x-rapidapi-host" => host,
        "x-rapidapi-key" => twin_key,
        "RapidAPIProject" => project_id
      }

      @entry = params[:entry]
      @words = current_user.lists.first.words

      url = "#{base + info[0]}entry=#{@entry}"
      callback = HTTP.get(url, headers: headers)
      response = JSON.parse(callback)
      @example = response['example'].first # retourne un array d'examples

      url = "#{base + info[1]}entry=#{@entry}"
      callback = HTTP.get(url, headers: headers)
      response = JSON.parse(callback)
      @difficulty = response["ten_degree"]

      url = "#{base + info[2]}entry=#{@entry}"
      callback = HTTP.get(url, headers: headers)
      response = JSON.parse(callback)
      definitions = response["meaning"].reject { |_k, v| v == "" } # clean les key vides
      @meanings = definitions.map { |_k, v| regex.match(v)[1] } # ne prend que la premiere def par type (nom, verbe, adverbe, adjectif)

      url = "#{base + info[3]}entry=#{@entry}"
      callback = HTTP.get(url, headers: headers)
      response = JSON.parse(callback)
      @synonyms = response["relation"]["broad_terms"].split(',').first(3)
    end
  end

end
