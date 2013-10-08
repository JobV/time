require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user
    user ||= User.new
  end

  test 'responds to email' do 
    assert_respond_to user, :email
  end

  test 'responds to first name' do
    assert_respond_to user, :first_name
  end
end
