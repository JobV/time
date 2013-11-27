require "test_helper"
require "feature_helper"

class CreateTimerTest < Capybara::Rails::TestCase
  def setup
    login
  end

  test "create a timer" do
    visit root_path

    fill_in 'new-time', with: '1h 30m'
    fill_in 'new-rate', with: '50'
    # select # something something
    # Choose from selector box the project
    # click_on 'Log'

    # assert_content page, '1h 30m'
    
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
