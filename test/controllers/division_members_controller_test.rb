require 'test_helper'

class DivisionMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get division_members_index_url
    assert_response :success
  end

end
