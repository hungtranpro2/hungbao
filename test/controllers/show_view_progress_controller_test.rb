require 'test_helper'

class ShowViewProgressControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get show_view_progress_show_url
    assert_response :success
  end

end
