require "test_helper"

class FormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form = forms(:one)
  end

  test "should get index" do
    get forms_url, as: :json
    assert_response :success
  end

  test "should create form" do
    assert_difference("Form.count") do
      post forms_url, params: { form: { carcolor: @form.carcolor, carnumber: @form.carnumber, clientname: @form.clientname, floor_id: @form.floor_id, price: @form.price, slot: @form.slot, status: @form.status } }, as: :json
    end

    assert_response :created
  end

  test "should show form" do
    get form_url(@form), as: :json
    assert_response :success
  end

  test "should update form" do
    patch form_url(@form), params: { form: { carcolor: @form.carcolor, carnumber: @form.carnumber, clientname: @form.clientname, floor_id: @form.floor_id, price: @form.price, slot: @form.slot, status: @form.status } }, as: :json
    assert_response :success
  end

  test "should destroy form" do
    assert_difference("Form.count", -1) do
      delete form_url(@form), as: :json
    end

    assert_response :no_content
  end
end
