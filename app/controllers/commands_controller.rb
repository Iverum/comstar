class CommandsController < ApplicationController
  before_action :validate_command

  USER_REGEX = /^<@UC\w+\|[\w\.]+>$/

  Command.register(:decide)
  Command.register(:roll)
  Command.register(:iam)

  def do
    response = Command.call_command(command, { text: params[:text], sender: params[:user_id] })
    case response.first
    when :error
      ephemeral response.last
    when :private
      ephemeral response.last
    when :ack
      acknowledge
      delay_in_channel response.last.call
    else
      in_channel response.last
    end
  end

  private

  def validate_command
    unless Command.valid? command
      return ephemeral Command.new.perform.last
    end
  end

  def command
    params[:command]&.gsub("/", "").to_sym
  end
end
