class CommandsController < ApplicationController
  before_action :validate_command

  USER_REGEX = /^<@UC\w+\|[\w\.]+>$/

  Command.register(:decide)
  Command.register(:roll)

  def do
    response = Command.call_command(command, params[:text], params[:user_id])
    if (response.first == :error)
      ephemeral response.last
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
