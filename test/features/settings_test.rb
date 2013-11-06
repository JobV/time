require "test_helper"

class SettingsTest < Capybara::Rails::TestCase

  def setup
    login
    visit settings_path
  end

  test "settings renders" do
    assert_content page, "Change your password"
    assert_content page, "Change your email"
    assert_content page, "Start Work"
  end

  test 'can change email' do
    fill_in :user_email, with: 'testert@new.com'
    click_on "Change my email"
    assert_equal 'testert@new.com', User.first.email
  end

  test 'can change password' do
    fill_in :user_password, with: 'jobiscool1'
    fill_in :user_password_confirmation, with: 'jobiscool1'
    click_on 'Change my password'
  end

  def user
    FactoryGirl.create(:user)
  end

  def login
    visit root_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Sign in'
  end
end
