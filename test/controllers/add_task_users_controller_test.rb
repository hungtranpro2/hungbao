require 'test_helper'

class AddTaskUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get add_task_users_index_url
    assert_response :success
  end

end
