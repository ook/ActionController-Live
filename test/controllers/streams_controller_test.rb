require "test_helper"

class StreamsControllerTest < ActionDispatch::IntegrationTest
  test "should get me" do
    get streams_me_url
    assert_response :success
  end
end
