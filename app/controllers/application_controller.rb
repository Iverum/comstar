class ApplicationController < ActionController::API
  private

  def ephemeral(message)
    return render json: { "response_type": "ephemeral", "text": message, "delete_original": "true" }
  end

  def in_channel(message)
    return render json: { "response_type": "in_channel", "text": message, "delete_original": "true" }
  end

  def delay_in_channel(message)
    HTTParty.post(params[:response_url],
                  body: { response_type: "in_channel", text: message}.to_json,
                  headers: { "Content-Type": "application/json" })
  end
end
