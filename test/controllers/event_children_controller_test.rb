require 'test_helper'

class EventChildrenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_child = event_children(:one)
  end

  test "should get index" do
    get event_children_url, as: :json
    assert_response :success
  end

  test "should create event_child" do
    assert_difference('EventChild.count') do
      post event_children_url, params: { event_child: { child_id: @event_child.child_id, event_id: @event_child.event_id } }, as: :json
    end

    assert_response 201
  end

  test "should show event_child" do
    get event_child_url(@event_child), as: :json
    assert_response :success
  end

  test "should update event_child" do
    patch event_child_url(@event_child), params: { event_child: { child_id: @event_child.child_id, event_id: @event_child.event_id } }, as: :json
    assert_response 200
  end

  test "should destroy event_child" do
    assert_difference('EventChild.count', -1) do
      delete event_child_url(@event_child), as: :json
    end

    assert_response 204
  end
end
