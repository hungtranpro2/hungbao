require 'test_helper'

class ProjectTasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_tasks_index_url
    assert_response :success
  end

end
