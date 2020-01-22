require 'test_helper'

class CommandsControllerTest < ActionDispatch::IntegrationTest
  test "should post do" do
    post "/"
    assert_response :success
  end

end
