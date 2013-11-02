require 'test_helper'
include Devise::TestHelpers


class SettingsControllerTest < ActionController::TestCase
  include Rails.application.routes.url_helpers

  def setup
    login
  end

  test '#index' do
    get :index
    assert_response :success
  end

  test '#update_email successful' do
    patch 'update_email', user: {email: 'test2@new.com'}
    assert_equal "Your email was changed.", flash[:notice]
    assert_response :redirect
  end

  test '#update_email unsuccessful' do
    patch 'update_email', user: {email: 'test2'}
    assert_equal "Make sure to enter a valid email address.", flash[:alert]
  end

  test '#update_password successful' do
    patch 'update_password', user: {password: 'jobiscool', password_confirmation: 'jobiscool'}
    assert_equal "Your password was changed.", flash[:notice]
    assert_response :redirect
  end

  test '#update_password unsuccessful' do
    patch 'update_password', user: {password: 'jobiscool', password_confirmation: 'asdf'}
    assert_equal "Your password was not changed, we did a whoopsie.", flash[:alert]
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
