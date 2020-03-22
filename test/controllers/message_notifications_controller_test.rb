require 'test_helper'

class MessageNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get message_notifications_index_url
    assert_response :success
  end

end
