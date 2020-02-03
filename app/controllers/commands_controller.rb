class CommandsController < ApplicationController
  before_action :validate_command

  DICE_REGEX = /^\d+d\d+$/i
  USER_REGEX = /^<@UC\w+\|[\w\.]+>$/
  VALID_CMDS = ["roll"].freeze

  def do
    send(command.to_sym)
  end

  private

  def roll
    return ephemeral "I didn't recognize that command. Try including some dice to roll." unless params[:text].present?

    # Split up the text
    possible_dice = params[:text].split
    # Check that each param meets the structure we expect
    return ephemeral "All arguments need to be in [number]d[size] format." unless possible_dice.all?{ |arg| DICE_REGEX.match?(arg) }

    dice = Dice.create_dice(possible_dice)
    return ephemeral "You can only roll up to 20 dice at a time." unless dice.length <= 20

    return ephemeral "You can only roll up to a d100." if dice.any? { |d| d.size > 100 }

    acknowledge
    # Everything looks okay, so we should roll the dice
    rolls = dice.map(&:roll)
    total = rolls.inject(0, :+)
    delay_in_channel("<@#{params[:user_id]}> rolled #{params[:text]}:\n #{rolls.join("+")}=#{total}")
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
