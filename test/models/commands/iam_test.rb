require 'test_helper'

class IamTest < ActiveSupport::TestCase
  test "reject a bio for being over 300 characters" do
    command = Commands::Iam.new({ text: "g3kPei68ZtdvN5zwUmceTHtPK4d97dNCafm1q1zZfchaaffbUAj1SEGyaCuwxyO9Y4aFD3bOvZRnaWVxJeKk70oTFvbBVRzyrQ7XVPuQuGvLJ4D27lLNEygDyZRpTGgqT8XAPKBVGK6R40SkyRCljZa4i7FQkPFnXJw2DJev4JoIrIZl1FgzEpLw2VIbbXX0XlWzNeeVC9HGPZ7K15b2djh3XlN5VyRnWR2NFqeCkxbCPEOu9irrevpoEdJ07DLxtUwwjH1HxervprvNCOUwGJbowaYtHkpOPvXsfS7DP7NBtoolong"})
    result = command.perform
    assert_equal :error, result.first
    assert_equal "Your bio must be 300 characters or less.", result.last
  end

  test "create a bio for a user" do
    command = Commands::Iam.new({ text: "Hello, world!", sender: "test_user_id" })
    result = command.perform
    assert_equal :private, result.first
    assert_equal "Your bio has been saved.", result.last
    user = User.last
    assert_equal "test_user_id", user.slack_id
    assert_equal "Hello, world!", user.bio
  end
end