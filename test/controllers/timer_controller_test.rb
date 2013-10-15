require "test_helper"

class TimersControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:timers)
  end

  test '#show works' do
    FactoryGirl.create(:timer)
    get :show, id: 1, format: :json
    assert_response :success
  end

  test '#create works' do
    post :create
    assert_equal 1, Timer.count
    assert_redirected_to timer_path(1)
  end

  test '#update' do
    FactoryGirl.create(:timer)
    post :update, id: 1
    assert_redirected_to timer_path(1)
  end


  test 'start should start a timer' do
    post :start
    assert_redirected_to timer_path(1)
    assert_equal 1, Timer.count
    assert_equal 1, Moment.count
  end
end
