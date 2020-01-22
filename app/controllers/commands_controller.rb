class CommandsController < ApplicationController
  def do
    render json: { "response_type": "ephemeral", "text": "Sorry, that didn't work. Please try again." }
  end
end
