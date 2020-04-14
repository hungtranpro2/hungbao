require 'test_helper'

class ProjectReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_reports_index_url
    assert_response :success
  end

end
