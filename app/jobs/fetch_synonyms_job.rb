class FetchSynonymsJob < ApplicationJob
  queue_as :default

  def perform(url)
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    @synonyms = response["relation"]["broad_terms"].split(',').first(3)
  end
end
