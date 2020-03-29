require 'test_helper'

class HelpTest < ActiveSupport::TestCase
  test "returns an error if no commands are registered" do
    command = Commands::Help.new
    result = command.perform
    assert_equal :error, result.first
    assert_equal "There are no commands available.", result.last
  end

  test "returns a list of valid registered commands" do
    Command.register(:help)
    Command.register(:roll)
    command = Commands::Help.new
    result = command.perform
    assert_equal :ok, result.first
    assert_equal "Available commands:\n- /help\n- /roll", result.last
  end
end