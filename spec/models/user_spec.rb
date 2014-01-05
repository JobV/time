require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }
  specify { expect(user).to respond_to(:admin) }
  specify { expect(user).to respond_to(:clients) }
  specify { expect(user).to respond_to(:timers) }
  specify { expect(user).to respond_to(:projects) }
  specify { expect(user).to respond_to(:activities) }
end