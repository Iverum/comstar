class CommandsController < ApplicationController
  before_action :validate_command

  DICE_REGEX = /^\d+d\d+$/i
  VALID_CMDS = ["roll"].freeze

  def do
    send(command.to_sym)
  end

  private

  def ephemeral(message)
    return render json: { "response_type": "ephemeral", "text": message }
  end

  def roll
    return ephemeral "I didn't recognize that command. Try including some dice to roll." unless params[:text]

    # Split up the text
    possible_dice = params[:text].split
    # Check that each param meets the structure we expect
    return ephemeral "All arguments need to be in [number]d[size] format." unless possible_dice.all?{ |arg| DICE_REGEX.match?(arg) }

    # Everything looks okay, so we should create the dice and roll them

    return ephemeral "Hey! You got it!"
  end

  def validate_command
    unless VALID_CMDS.include? command
      return ephemeral "Sorry, that didn't work. Please try again."
    end
  end

  def command
    params[:command]&.gsub("/", "")
  end
end
