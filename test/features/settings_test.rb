require "test_helper"

class SettingsTest < Capybara::Rails::TestCase

  def setup
    login
  end

  test "settings renders" do
    click_on "Settings"
    assert_content page, "Change your password"
    assert_content page, "Change your email"
    assert_content page, "Timers"
  end

  test 'can change email' do

  end

  test 'can change password' do

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
