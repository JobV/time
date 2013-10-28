require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  test 'login' do
    get root_path
    assert_redirected_to new_user_session_path
  end

  test 'without session get redirected' do

  end
end
