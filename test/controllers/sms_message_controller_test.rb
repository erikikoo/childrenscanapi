require 'test_helper'

class SmsMessageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sms_message_index_url
    assert_response :success
  end

  test "should get show" do
    get sms_message_show_url
    assert_response :success
  end

  test "should get create" do
    get sms_message_create_url
    assert_response :success
  end

  test "should get delete" do
    get sms_message_delete_url
    assert_response :success
  end

end
