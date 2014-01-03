require 'spec_helper'

describe Client do
  ATTRIBUTES = [:kvk, :postal_code, :company_name, :contact_person, :address]
  let(:client) { FactoryGirl.build(:client) }

  ATTRIBUTES.each do |attr|
    specify { expect(client).to respond_to(attr) }
  end

  describe 'relationships' do
    specify { expect(client).to respond_to(:users) }
    specify { expect(client).to respond_to(:timers) }
    specify { expect(client).to respond_to(:projects) }
  end

  it 'validates company_name' do
    false_client = FactoryGirl.build(:client, company_name: "")
    expect(false_client).to_not be_valid
  end
end

