require 'test_helper'
include Devise::TestHelpers

class SettingsControllerTest < ActionController::TestCase
  def setup
    login
  end

  test '#index' do
    get :index
    assert_response :success
  end

  private

  def user
    FactoryGirl.create(:user)
  end

  def login
    sign_in(user)
    assert_response 200
  end
end
