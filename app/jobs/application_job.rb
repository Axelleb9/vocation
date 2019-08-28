class ApplicationJob < ActiveJob::Base
  private

  def headers
    {
      "x-rapidapi-host" => ENV["HOST"],
      "x-rapidapi-key" => ENV["TWINKEY"],
      "RapidAPIProject" => ENV["PROJECTID"]
    }
  end
end
