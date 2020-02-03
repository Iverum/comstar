class ApplicationController < ActionController::API
  private

  def ephemeral(message)
    render json: { "response_type": "ephemeral", "text": message }
  end

  def in_channel(message)
    render json: { "response_type": "in_channel", "text": message }
  end
end
