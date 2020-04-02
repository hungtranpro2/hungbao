require 'test_helper'

class ManageDivisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_divisions_index_url
    assert_response :success
  end

end
