class CommandsController < ApplicationController
  before_action :validate_command

  DICE_REGEX = /^\d+d\d+$/i
  USER_REGEX = /^<@UC\w+\|[\w\.]+>$/

  Command.register(:decide)
  Command.register(:roll)

  def do
    response = Command.call_command(command, params[:text])
    if (response.first == :error)
      ephemeral response.last
    else
      in_channel response.last
    end
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
    unless Command.valid? command
      return ephemeral Command.new.perform.last
    end
  end

  def command
    params[:command]&.gsub("/", "").to_sym
  end
end
