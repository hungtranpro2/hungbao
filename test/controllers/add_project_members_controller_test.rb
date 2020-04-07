require 'test_helper'

class AddProjectMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get add_project_members_index_url
    assert_response :success
  end

end
