require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  test "should get regions" do
    get :regions
    assert_response :success
  end

end
