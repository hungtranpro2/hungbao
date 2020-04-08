require 'test_helper'

class DivisionReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get division_reports_index_url
    assert_response :success
  end

end
