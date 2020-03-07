require 'test_helper'

class RoomChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get room_chats_index_url
    assert_response :success
  end

  test "should get show" do
    get room_chats_show_url
    assert_response :success
  end

  test "should get new" do
    get room_chats_new_url
    assert_response :success
  end

  test "should get create" do
    get room_chats_create_url
    assert_response :success
  end

end
