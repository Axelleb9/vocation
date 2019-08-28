class FetchDefinitionJob < ApplicationJob
  queue_as :default
  BASE_URL = "https://twinword-word-graph-dictionary.p.rapidapi.com/definition/?"

  def perform(word, user_id, word_id)
    regex = /(^.*$)/
    regex2 = /(\(.{3}\))/
    url = BASE_URL + "entry=#{word}"
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    definitions = response["meaning"].reject { |_k, v| v == "" }
    meanings = definitions.map { |_k, v| regex.match(v)[1] }
    natures = meanings.map { |i| regex2.match(i)[1].gsub(/\W/, '') }
    send_details(meanings, user_id, natures, word)
    w = Word.find(word_id)
    w.update(definition: meanings, nature: natures)
  end

  def send_details(detail, id, natures, translation)
    ActionCable.server.broadcast("word_details_user_#{id}",
    { type: "definition", detail: detail, natures: natures, translation: translation })
  end
end
