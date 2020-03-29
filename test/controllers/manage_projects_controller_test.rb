require 'test_helper'

class ManageProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_projects_index_url
    assert_response :success
  end

end
