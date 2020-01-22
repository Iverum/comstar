require 'test_helper'

class CommandsControllerTest < ActionDispatch::IntegrationTest
  test "should post do" do
    post "/"
    assert_response :success
  end

  test "should handle roll" do
    expected = { "response_type": "ephemeral", "text": "Hey! You got it!" }
    post "/", params: { command: "roll" }
    assert_response :success
    assert_equal expected, response.parsed_body.symbolize_keys
  end
end
