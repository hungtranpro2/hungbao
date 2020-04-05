require 'test_helper'

class ApprovalRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get approval_requests_index_url
    assert_response :success
  end

end
