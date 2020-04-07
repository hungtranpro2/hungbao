require 'test_helper'

class ProjectMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_members_index_url
    assert_response :success
  end

end
