require 'spec_helper'


describe Timer do
  ATTRIBUTES = [:total_time, :end_time, :time]

  let(:timer) { FactoryGirl.build(:timer) }
  subject { timer }

  ATTRIBUTES.each do |attr|
    specify { expect(subject).to respond_to(attr) }
  end
end
