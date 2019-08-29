class FetchTranslationJob < ApplicationJob
  queue_as :default
  BASE_URL = "https://translate.yandex.net/api/v1.5/tr.json/translate?"

  def perform(word, user_id, word_id)
    languages = "en-fr"
    url = "#{BASE_URL}lang=#{languages}&key=#{ENV["YANKEY"]}&text=#{word}"
    callback = JSON.parse(HTTP.get(url))
    translation = callback["text"].first
    send_details(translation, user_id)
    w = Word.find(word_id)
    w.update!(translation: translation)
  end

  def send_details(detail, id)
    ActionCable.server.broadcast("word_details_user_#{id}",
    { type: "translation", detail: detail })
  end
end
