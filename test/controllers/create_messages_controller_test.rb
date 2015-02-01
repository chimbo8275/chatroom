require 'test_helper'

class CreateMessagesControllerTest < ActionController::TestCase
  setup do
    @create_message = create_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:create_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create create_message" do
    assert_difference('CreateMessage.count') do
      post :create, create_message: { author_id: @create_message.author_id, body: @create_message.body, room_id: @create_message.room_id }
    end

    assert_redirected_to create_message_path(assigns(:create_message))
  end

  test "should show create_message" do
    get :show, id: @create_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @create_message
    assert_response :success
  end

  test "should update create_message" do
    patch :update, id: @create_message, create_message: { author_id: @create_message.author_id, body: @create_message.body, room_id: @create_message.room_id }
    assert_redirected_to create_message_path(assigns(:create_message))
  end

  test "should destroy create_message" do
    assert_difference('CreateMessage.count', -1) do
      delete :destroy, id: @create_message
    end

    assert_redirected_to create_messages_path
  end
end
