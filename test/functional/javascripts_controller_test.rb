require 'test_helper'

class JavascriptsControllerTest < ActionController::TestCase
  test "should get departments" do
    get :departments
    assert_response :success
  end

end
