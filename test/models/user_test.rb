require "test_helper"

describe User do

  let(:user_params) { { email:                  "new@example.com", 
                        password:               "testtest", 
                        password_confirmation:  "testtest",
                        first_name:             "John",
                        last_name:              "Doe"
                        } }
                        
  let(:user) { User.new(user_params) }

  it 'is valid' do
    user.must_be :valid?
  end

  it 'does not validate first name' do
    user.first_name = nil
    user.must_be :valid?
  end

  it 'does not validate last name' do
    user.last_name = nil
    user.must_be :valid?
  end

  it 'validates email' do
    user.email = nil
    user.wont_be :valid?
  end

  it 'validates password' do
    user.password = nil
    user.wont_be :valid?
  end
end
