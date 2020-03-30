require 'test_helper'

class CommandTest < ActiveSupport::TestCase
  setup do
    Command.register(:decide)
  end

  teardown do
    Command.unregister(:decide)
  end

  test "run a basic unknown command" do
    command = Command.new({})
    assert_equal [:error, "I don't understand that command.\nAvailable commands:\n- /decide"], command.perform
  end

  test "register a command and call it" do
    args = ["one", "two", "three"]
    response = Command.call_command(:decide, { text: args.join("|") })
    assert args.include? response.last
  end
end