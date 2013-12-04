require 'spec_helper'
describe Timer do
  ATTRIBUTES = [:total_time, :end_time]

  let(:timer) { FactoryGirl.build(:timer) }

  ATTRIBUTES.each do |attr|
    specify { expect(timer).to respond_to(attr) }
  end
end
