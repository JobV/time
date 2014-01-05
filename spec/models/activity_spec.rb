require 'spec_helper'

describe Activity do
  let(:activity) { FactoryGirl.build(:activity) }
  it 'responds' do
    expect(activity).to respond_to(:name)
  end
end
