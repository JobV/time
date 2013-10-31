require "test_helper"
include Devise::TestHelpers

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

  # TODO: include route helpers, post is not recognized
  # test '#stop' do
  #   timer = FactoryGirl.create(:timer)
  #   post '/timers/1'
  #   assert_response :success
  # end

  private

  def user
    FactoryGirl.create(:user)
  end

  def login
    sign_in(user)
    assert_response 200
  end
end
