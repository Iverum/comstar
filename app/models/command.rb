class Command
  @registered_commands = []

  class << self
    def register(command)
      @registered_commands << command
    end

    def call_command(name, *args)
      command = "Commands::#{name.to_s.classify}".constantize.new(args)
      command.perform
    end
  end

  def initialize(*args)
    @args = args.flatten
  end

  def perform
    return "I don't understand that command."
  end
end