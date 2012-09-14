require 'test_helper'

class ExperimentControllerTest < ActionController::TestCase
  test "should get begin" do
    get :begin
    assert_response :success
  end

  test "should get thank_you" do
    get :thank_you
    assert_response :success
  end

  test "should get familiar" do
    get :familiar
    assert_response :success
  end

end
