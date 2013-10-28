require "test_helper"
require "factory"

class TimersControllerTest < ActionController::TestCase
  def setup
    login
  end

  test '#index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:timers)
  end

  test '#show' do
    FactoryGirl.create(:timer)
    get :show, id: 1, format: :json
    assert_response :success
  end

  test '#create' do
    post :create
    assert_equal 1, Timer.count
    assert_redirected_to timer_path(1)
  end

  test '#update' do
    FactoryGirl.create(:timer)
    patch :update, id: 1
    assert_redirected_to timer_path(1)
  end

  test '#destroy' do
    FactoryGirl.create(:timer)
    delete :destroy, id: 1
    assert_equal 0, Timer.count
  end

  private

  def user
    user ||= FactoryGirl.create(:user)
  end

  def login
        # post the login and follow through to the home page
    post "/users/sign_in", username: user.email,
      password: user.password
    follow_redirect!
    assert_equal 200, status
    assert_equal "/", path
  end
end
