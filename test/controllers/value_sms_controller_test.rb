require 'test_helper'

class ValueSmsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @value_sm = value_sms(:one)
  end

  test "should get index" do
    get value_sms_url, as: :json
    assert_response :success
  end

  test "should create value_sm" do
    assert_difference('ValueSm.count') do
      post value_sms_url, params: { value_sm: { value_per_sms: @value_sm.value_per_sms } }, as: :json
    end

    assert_response 201
  end

  test "should show value_sm" do
    get value_sm_url(@value_sm), as: :json
    assert_response :success
  end

  test "should update value_sm" do
    patch value_sm_url(@value_sm), params: { value_sm: { value_per_sms: @value_sm.value_per_sms } }, as: :json
    assert_response 200
  end

  test "should destroy value_sm" do
    assert_difference('ValueSm.count', -1) do
      delete value_sm_url(@value_sm), as: :json
    end

    assert_response 204
  end
end
