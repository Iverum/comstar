module Commands
  class Help < Command
    def perform
      return error "There are no commands available." if Command.registered_commands.empty?

      ok "Available commands:\n#{format_available_commands}"
    end

    private

    def format_available_commands
      commands = Command.registered_commands.map{ |command| "- /#{command.to_s}" }
      commands.join("\n")
    end
  end
end