class FetchDifficultyJob < ApplicationJob
  queue_as :default
  BASE_URL = "https://twinword-word-graph-dictionary.p.rapidapi.com/difficulty/?"

  def perform(word, user_id, word_id)
    url = BASE_URL + "entry=#{word}"
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    difficulty = response["ten_degree"]
    send_details(difficulty, user_id)
    w = Word.find(word_id)
    w.update(difficulty: difficulty)
  end

  def send_details(detail, id)
    ActionCable.server.broadcast("word_details_user_#{id}",
    { detail: detail })
  end
end
