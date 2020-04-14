require 'test_helper'

class OverviewProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get overview_projects_index_url
    assert_response :success
  end

end
