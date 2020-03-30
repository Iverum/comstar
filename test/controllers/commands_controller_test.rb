require 'test_helper'

class CommandsControllerTest < ActionDispatch::IntegrationTest
  test "should return error message for no dice" do
    expected = { "response_type": "ephemeral", "text": "I didn't recognize that command. Try including some dice to roll." }
    post "/", params: { command: "/roll", "text": "" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end

  test "should return syntax error message for badly formatted dice" do
    expected = { "response_type": "ephemeral", "text": "All arguments need to be in [number]d[size] format." }
    post "/", params: { command: "/roll", text: "2d6 nope" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end

  test "should return error for too many dice" do
    expected = { "response_type": "ephemeral", "text": "You can only roll up to 20 dice at a time." }
    post "/", params: { command: "/roll", text: "21d6" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end

  test "should return error for too big dice" do
    expected = { "response_type": "ephemeral", "text": "You can only roll up to a d100." }
    post "/", params: { command: "/roll", text: "2d101" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end

  test "should handle roll" do
    post "/", params: { command: "/roll", text: "2d6 3d10", response_url: "http://example.com" }
    assert_response :success
  end

  test "should decide" do
    expected = { "response_type": "in_channel", "text": "one" }
    post "/", params: { command: "/decide", text: "one", response_url: "http://example.com" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end

  test "should register a user and respond ephemerally" do
    expected = { "response_type": "ephemeral", "text": "Your bio has been saved." }
    post "/", params: { command: "/iam", text: "Hello, world!", response_url: "http://www.example.com" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end
end
