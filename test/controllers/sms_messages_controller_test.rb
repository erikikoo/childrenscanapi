require 'test_helper'

class SmsMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sms_message = sms_messages(:one)
  end

  test "should get index" do
    get sms_messages_url, as: :json
    assert_response :success
  end

  test "should create sms_message" do
    assert_difference('SmsMessage.count') do
      post sms_messages_url, params: { sms_message: { child_id: @sms_message.child_id, monitor_user_id: @sms_message.monitor_user_id, status: @sms_message.status } }, as: :json
    end

    assert_response 201
  end

  test "should show sms_message" do
    get sms_message_url(@sms_message), as: :json
    assert_response :success
  end

  test "should update sms_message" do
    patch sms_message_url(@sms_message), params: { sms_message: { child_id: @sms_message.child_id, monitor_user_id: @sms_message.monitor_user_id, status: @sms_message.status } }, as: :json
    assert_response 200
  end

  test "should destroy sms_message" do
    assert_difference('SmsMessage.count', -1) do
      delete sms_message_url(@sms_message), as: :json
    end

    assert_response 204
  end
end
