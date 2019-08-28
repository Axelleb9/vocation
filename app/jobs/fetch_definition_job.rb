class FetchDefinitionJob < ApplicationJob
  queue_as :default

  def perform(url)
    # Do something later
    callback = HTTP.get(url, headers: headers)
    response = JSON.parse(callback)
    definitions = response["meaning"].reject { |_k, v| v == "" }
    @meanings = definitions.map { |_k, v| regex.match(v)[1] }
  end
end
