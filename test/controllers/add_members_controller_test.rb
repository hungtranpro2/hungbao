require 'test_helper'

class AddMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get add_members_index_url
    assert_response :success
  end

end
