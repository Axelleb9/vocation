class FetchSynonymsJob < ApplicationJob
  queue_as :default
  BASE_URL = "https://twinword-word-graph-dictionary.p.rapidapi.com/reference/?"

  def perform(word, user_id, word_id)
    url = BASE_URL + "entry=#{word}"
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    synonyms = response["relation"]["broad_terms"].split(',').first(3)
    send_details(synonyms, user_id)
    reference = Reference.new
    response["relation"].each do |relation, terms|
      unless terms == ""
        case relation
        when "broad_terms"
          reference.broad_terms = terms.split(',')
        when "narrow_terms"
          reference.narrow_terms = terms.split(',')
        when "related_terms"
          reference.related_terms = terms.split(',')
        when "synonyms"
          reference.synonyms = terms.split(',')
        end
      end
    end
    w = Word.find(word_id)
    reference.word = w
    reference.save
  end

  def send_details(detail, id)
    ActionCable.server.broadcast("word_details_user_#{id}",
    { type: "synonyms", detail: detail })
  end
end
