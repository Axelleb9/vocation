class FetchDifficultyJob < ApplicationJob
  queue_as :default

  def perform(url)
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
  end
end
