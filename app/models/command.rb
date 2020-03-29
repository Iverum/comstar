class Command
  @registered_commands = []

  class << self
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

  def initialize(args)
    @args = args
  end

  def perform
    error "I don't understand that command."
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