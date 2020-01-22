class CommandsController < ApplicationController
  before_action :validate_command

  VALID_CMDS = ["roll"].freeze

  def do
    send(command.to_sym)
  end

  private

  def roll
    render json: { "response_type": "ephemeral", "text": "Hey! You got it!" }
  end

  def validate_command
    unless VALID_CMDS.include? command
      render json: { "response_type": "ephemeral", "text": "Sorry, that didn't work. Please try again." }
    end
  end

  def command
    params[:command]&.gsub("/", "")
  end
end
