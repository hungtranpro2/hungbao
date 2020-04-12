require 'test_helper'

class MyWorksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_works_index_url
    assert_response :success
  end

end
