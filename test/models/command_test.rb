require 'test_helper'

class CommandTest < ActiveSupport::TestCase
  test "run a basic unknown command" do
    command = Command.new({})
    assert_equal [:error, "I don't understand that command."], command.perform
  end

  test "register a command and call it" do
    Command.register(:decide)
    args = ["one", "two", "three"]
    response = Command.call_command(:decide, { text: args.join("|") })
    assert args.include? response.last
  end
end