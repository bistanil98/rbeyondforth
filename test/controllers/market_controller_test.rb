require 'test_helper'

class MarketControllerTest < ActionController::TestCase
  test "should get market_grade" do
    get :market_grade
    assert_response :success
  end

  test "should get market_grade_report" do
    get :market_grade_report
    assert_response :success
  end
  test "should get certification" do
    get :certification
    assert_response :success
  end
end
