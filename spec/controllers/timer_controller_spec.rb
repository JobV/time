require 'spec_helper'

describe TimersController do
  include Devise::TestHelpers
  let(:user) { FactoryGirl.build(:user) }
  before { sign_in user }

  describe '.index' do
    # specify { expect(described_class).to assign(@timers) }
  end
end
