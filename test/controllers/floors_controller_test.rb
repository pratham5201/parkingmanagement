require "test_helper"

class FloorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @floor = floors(:one)
  end

  test "should get index" do
    get floors_url, as: :json
    assert_response :success
  end

  test "should create floor" do
    assert_difference("Floor.count") do
      post floors_url, params: { floor: { floor: @floor.floor } }, as: :json
    end

    assert_response :created
  end

  test "should show floor" do
    get floor_url(@floor), as: :json
    assert_response :success
  end

  test "should update floor" do
    patch floor_url(@floor), params: { floor: { floor: @floor.floor } }, as: :json
    assert_response :success
  end

  test "should destroy floor" do
    assert_difference("Floor.count", -1) do
      delete floor_url(@floor), as: :json
    end

    assert_response :no_content
  end
end
