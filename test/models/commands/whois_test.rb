require 'test_helper'

class WhoisTest < ActiveSupport::TestCase
  test "reject if no user is found in the message" do
    command = Commands::Whois.new({ text: "What is this?"})
    result = command.perform
    assert_equal :error, result.first
    assert_equal "I did not recognize a user in that request.", result.last
  end

  test "reject if no user is found in the database" do
    slack_id = "UC95B60PK"
    command = Commands::Whois.new({ text: "<@#{slack_id}|joe.bob>"})
    result = command.perform
    assert_equal :error, result.first
    assert_equal "I couldn't find a bio for <@#{slack_id}>.", result.last
  end

  test "return the bio if a user is found" do
    slack_id = "UC95B60PK"
    User.create(slack_id: slack_id, bio: "Hello, world!")
    command = Commands::Whois.new({ text: "<@#{slack_id}|joe.bob>"})
    result = command.perform
    assert_equal :private, result.first
    assert_equal "<@#{slack_id}> describes themselves:\n'Hello, world!'", result.last
  end
end