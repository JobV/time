require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user
    user ||= User.new
  end

  ATTRIBUTES = %w(email, first_name, last_name, timers, projects)

  test 'responders' do 
    ATTRIBUTES.each do |attribute|
      assert_respond_to user, attribute
    end
  end
end
