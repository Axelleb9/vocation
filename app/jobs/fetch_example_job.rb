class FetchExampleJob < ApplicationJob
  queue_as :default
  BASE_URL = "https://twinword-word-graph-dictionary.p.rapidapi.com/example/?"

  def perform(word, user_id, word_id)
    url = BASE_URL + "entry=#{word}"
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    example = response["example"].first
    send_details(example, user_id)
    w = Word.find(word_id)
    w.update(example: example)
  end

  def send_details(detail, id)
    ActionCable.server.broadcast("word_details_user_#{id}",
    { type: "example", detail: detail })
  end
end
