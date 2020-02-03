class ApplicationController < ActionController::API
  private

  def acknowledge
    head :ok
  end

  def ephemeral(message)
    return render json: { "response_type": "ephemeral", "text": message }
  end

  def in_channel(message)
    return render json: { "response_type": "in_channel", "text": message }
  end

  def delay_in_channel(message)
    HTTParty.post(params[:response_url],
                  body: { response_type: "in_channel", text: message}.to_json,
                  headers: { "Content-Type": "application/json" })
  end
end
