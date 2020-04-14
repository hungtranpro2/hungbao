require 'test_helper'

class ResetPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get reset_passwords_edit_url
    assert_response :success
  end

end
