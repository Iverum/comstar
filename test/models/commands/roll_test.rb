require 'test_helper'

class RollTest < ActiveSupport::TestCase
  test "fail is does not include dice" do
    command = Commands::Roll.new({ text: "", sender: "user_id" })
    response = command.perform
    assert_equal "I didn't recognize that command. Try including some dice to roll.", response.last
  end

  test "fail if dice are not in correct format" do
    command = Commands::Roll.new({ text: "not dice", sender: "user_id" })
    response = command.perform
    assert_equal "All arguments need to be in [number]d[size] format.", response.last
  end

  test "fail if more than 20 dice are provided" do
    command = Commands::Roll.new({ text: "21d6", sender: "user_id" })
    response = command.perform
    assert_equal "You can only roll up to 20 dice at a time.", response.last
  end

  test "fail if any dice are over d100" do
    command = Commands::Roll.new({ text: "2d1000", sender: "user_id" })
    response = command.perform
    assert_equal "You can only roll up to a d100.", response.last
  end

  test "roll dice" do
    command = Commands::Roll.new({ text: "1d1", sender: "user_id" })
    response = command.perform
    assert_equal :ack, response.first
    assert_equal "<@user_id> rolled 1d1:\n 1=1", response.last.call
  end
end