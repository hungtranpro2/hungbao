require 'test_helper'

class CompanyReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get company_reports_index_url
    assert_response :success
  end

end
