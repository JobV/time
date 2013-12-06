require 'spec_helper'
describe Timer do
  ATTRIBUTES = [:total_time, :end_time, :total_value]

  let(:timer) { FactoryGirl.build(:timer) }

  ATTRIBUTES.each do |attr|
    specify { expect(timer).to respond_to(attr) }
  end

  describe '.parse_time' do
    context '2h' do
      before { timer.written_time = '2h' }
      specify { expect(timer.parse_time).to eq 7200 }
    end
    context '2m' do
      before { timer.written_time = '2m' }
      specify { expect(timer.parse_time).to eq 120 }
    end
    context '2s' do
      before { timer.written_time = '2s' }
      specify { expect(timer.parse_time).to eq 2 }
    end
  end
end
