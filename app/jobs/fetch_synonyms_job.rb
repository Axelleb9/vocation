class FetchSynonymsJob < ApplicationJob
  queue_as :default
  BASE_URL = "https://twinword-word-graph-dictionary.p.rapidapi.com/reference/?"

  def perform(word, user_id, word_id)
    url = BASE_URL + "entry=#{word}"
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    synonyms = response["relation"]["broad_terms"].split(',').first(3)
    w = Word.find(word_id)
    w.update(synonyms: synonyms)
  end
end
