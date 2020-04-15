require 'test_helper'

class CompanyMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get company_members_index_url
    assert_response :success
  end

end
