require 'test_helper'

class CompanyTasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get company_tasks_index_url
    assert_response :success
  end

end
