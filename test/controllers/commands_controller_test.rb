require 'test_helper'

class CommandsControllerTest < ActionDispatch::IntegrationTest
  test "should post do" do
    post "/"
    assert_response :success
  end

  test "should return error message for no dice" do
    expected = { "response_type": "ephemeral", "text": "I didn't recognize that command. Try including some dice to roll." }
    post "/", params: { command: "/roll" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end

  test "should return syntax error message for badly formatted dice" do
    expected = { "response_type": "ephemeral", "text": "All arguments need to be in [number]d[size] format." }
    post "/", params: { command: "/roll", text: "2d6 nope" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end

  test "should handle roll" do
    expected = { "response_type": "ephemeral", "text": "Hey! You got it!" }
    post "/", params: { command: "/roll", text: "2d6 3d10" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end
end
