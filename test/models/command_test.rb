require 'test_helper'

class CommandTest < ActiveSupport::TestCase
  test "run a basic unknown command" do
    command = Command.new
    assert_equal "I don't understand that command.", command.perform
  end
end