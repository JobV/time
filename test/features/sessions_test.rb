require "test_helper"

class SessionsTest < Capybara::Rails::TestCase
  test "sign in without account" do
    visit root_path
    refute_content page, "Sign out"

    fill_in :user_email, with: 'test@new.com'
    fill_in :user_password, with: 'test1234'
    click_button 'Sign in'

    assert_content page, "Invalid email or password."
  end
end
