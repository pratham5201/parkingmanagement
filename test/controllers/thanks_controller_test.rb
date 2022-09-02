require "test_helper"

class ThanksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get thanks_index_url
    assert_response :success
  end
end
