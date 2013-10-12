require "test_helper"

class TimersControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:timers)
  end

  test 'start should start a timer' do
    post :start
    assert_response :success
    assert_equal 1, Timer.count
    assert_equal 1, Moment.count
  end
end
