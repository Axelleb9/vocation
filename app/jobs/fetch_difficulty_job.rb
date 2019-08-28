class FetchDifficultyJob < ApplicationJob
  queue_as :default
  BASE_URL = "https://twinword-word-graph-dictionary.p.rapidapi.com/difficulty/?"

  def perform(word, user_id, word_id)
    url = BASE_URL + "entry=#{word}"
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    w = Word.find(word_id)
    w.update(difficulty: response["ten_degree"])
  end
end
