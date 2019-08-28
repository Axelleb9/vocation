class FetchSynonymsJob < ApplicationJob
  queue_as :default
  BASE_URL = "https://twinword-word-graph-dictionary.p.rapidapi.com/reference/?"

  def perform(word, user_id, word_id)
    url = BASE_URL + "entry=#{word}"
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    synonyms = response["relation"]["broad_terms"].split(',').first(3)
    send_details(synonyms, user_id)
    w = Word.find(word_id)
    w.update(synonyms: synonyms)
  end

  def send_details(detail, id)
    ActionCable.server.broadcast("word_details_user_#{id}",
    { type: "synonyms", detail: detail })
  end
end
