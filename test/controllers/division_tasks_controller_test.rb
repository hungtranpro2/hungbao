require 'test_helper'

class DivisionTasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get division_tasks_index_url
    assert_response :success
  end

end
