class WordDetailsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "word_details_user_#{params[:user_id]}"
  end
end
