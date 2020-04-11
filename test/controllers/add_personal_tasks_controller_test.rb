require 'test_helper'

class AddPersonalTasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get add_personal_tasks_index_url
    assert_response :success
  end

end
