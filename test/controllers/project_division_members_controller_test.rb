require 'test_helper'

class ProjectDivisionMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_division_members_index_url
    assert_response :success
  end

end
