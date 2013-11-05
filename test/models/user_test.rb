require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user
    user ||= User.new
  end

  test 'responders' do 
    assert_respond_to user, :email
    assert_respond_to user, :first_name
    assert_respond_to user, :timers
    assert_respond_to user, :projects
  end
end
