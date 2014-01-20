require 'spec_helper'

describe User do
  USER_ATTRIBUTES = [
    :admin,
    :clients,
    :timers,
    :projects,
    :activities]

  let(:user) { FactoryGirl.build(:user) }

  USER_ATTRIBUTES.each do |attr|
    specify { expect(user).to respond_to(attr) }
  end
end
