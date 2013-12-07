require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }
  specify { expect(user).to respond_to(:admin) }
end