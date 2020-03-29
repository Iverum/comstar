require 'test_helper'

class RollTest < ActiveSupport::TestCase
  test "fail is does not include dice" do
    command = Commands::Roll.new("", "user_id")
    response = command.perform
    assert_equal "I didn't recognize that command. Try including some dice to roll.", response.last
  end

  test "fail if dice are not in correct format" do
    command = Commands::Roll.new("not dice", "user_id")
    response = command.perform
    assert_equal "All arguments need to be in [number]d[size] format.", response.last
  end

  test "fail if more than 20 dice are provided" do
    command = Commands::Roll.new("21d6", "user_id")
    response = command.perform
    assert_equal "You can only roll up to 20 dice at a time.", response.last
  end

  test "fail if any dice are over d100" do
    command = Commands::Roll.new("2d1000", "user_id")
    response = command.perform
    assert_equal "You can only roll up to a d100.", response.last
  end

  test "roll dice" do
    command = Commands::Roll.new("1d1", "user_id")
    response = command.perform
    assert_equal "<@user_id> rolled 1d1:\n 1=1", response.last
  end
end