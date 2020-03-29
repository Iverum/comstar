require 'test_helper'

class DecideTest < ActiveSupport::TestCase
  test "fail to perform with no options" do
    command = Commands::Decide.new
    result = command.perform
    assert_equal [:error, "I didn't recognize that command. Try including some options to decide upon."], result
  end

  test "return the first option if only one option is given" do
    command = Commands::Decide.new("one")
    response = command.perform
    assert_equal "one", response.last
  end

  test "select a random option" do
    args = ["one", "two", "three"]
    command = Commands::Decide.new(args.join("|"))
    response = command.perform
    assert args.include? response.last
  end
end