require 'test_helper'

class MonitorUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monitor_user = monitor_users(:one)
  end

  test "should get index" do
    get monitor_users_url, as: :json
    assert_response :success
  end

  test "should create monitor_user" do
    assert_difference('MonitorUser.count') do
      post monitor_users_url, params: { monitor_user: { access_count: @monitor_user.access_count, login: @monitor_user.login, name: @monitor_user.name, user_id: @monitor_user.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show monitor_user" do
    get monitor_user_url(@monitor_user), as: :json
    assert_response :success
  end

  test "should update monitor_user" do
    patch monitor_user_url(@monitor_user), params: { monitor_user: { access_count: @monitor_user.access_count, login: @monitor_user.login, name: @monitor_user.name, user_id: @monitor_user.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy monitor_user" do
    assert_difference('MonitorUser.count', -1) do
      delete monitor_user_url(@monitor_user), as: :json
    end

    assert_response 204
  end
end
