require 'test_helper'

class ShowReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get show_reports_show_url
    assert_response :success
  end

end
