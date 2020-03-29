require 'test_helper'

class HelpTest < ActiveSupport::TestCase
  setup do
    Command.register(:help)
    Command.register(:roll)
  end

  teardown do
    Command.unregister(:help)
    Command.unregister(:roll)
  end

  test "returns an error if no commands are registered" do
    Command.unregister(:help)
    Command.unregister(:roll)
    command = Commands::Help.new
    result = command.perform
    assert_equal :error, result.first
    assert_equal "There are no commands available.", result.last
  end

  test "returns a list of valid registered commands" do
    command = Commands::Help.new
    result = command.perform
    assert_equal :ok, result.first
    assert_equal "Available commands:\n- /help\n- /roll", result.last
  end
end