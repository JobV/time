require 'spec_helper'

describe Project do
  ATTRIBUTES = [:name, :hourly_rate]
  let(:project) { FactoryGirl.build(:project) }

  ATTRIBUTES.each do |attr|
    specify { expect(project).to respond_to(attr) }
  end

  describe 'relationships' do
    specify { expect(project).to respond_to(:users) }
    specify { expect(project).to respond_to(:timers) }
    specify { expect(project).to respond_to(:client) }
  end
end

