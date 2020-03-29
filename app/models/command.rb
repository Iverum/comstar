class Command
  @registered_commands = []

  class << self
    attr_reader :registered_commands

    def register(command)
      @registered_commands << command
    end

    def valid?(command)
      @registered_commands.include? command
    end

    def call_command(name, args)
      command = "Commands::#{name.to_s.classify}".constantize.new(args)
      command.perform
    end
  end

  def initialize(args = {})
    @args = args
  end

  def perform
    available_commands = Commands::Help.new.perform.last
    error "I don't understand that command.\n#{available_commands}"
  end

  private

  def error(message)
    [:error, message]
  end

  def ack(delay)
    [:ack, delay]
  end

  def ok(message)
    [:ok, message]
  end
end