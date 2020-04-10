require 'test_helper'

class PersonalTasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get personal_tasks_index_url
    assert_response :success
  end

end
