require 'spec_helper'

describe Client do
  CLIENT_ATTRIBUTES = [
    :kvk, 
    :postal_code, 
    :company_name, 
    :contact_person, 
    :address, 
    :city]

  let(:client)  { FactoryGirl.create(:client) }
  let(:project) { FactoryGirl.create(:project, client_id: client.id) }

  CLIENT_ATTRIBUTES.each do |attr|
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

  let(:timer_1) { 
    FactoryGirl.create(:timer, 
      project_id: project.id, 
      total_value: 12, 
      total_time: 120) }

  let(:timer_2) { 
    FactoryGirl.create(:timer, 
      project_id: project.id, 
      total_value: 38, 
      total_time: 130) }

  describe 'totals' do
    describe '.uninvoiced' do
      it 'returns the uninvoiced totals' do
        timer_1 && timer_2
        client.calculate_totals
        expect(client.uninvoiced).to eq 50
        expect(client.uninvoiced_time).to eq 250
      end

      it 'returns 0 when there are no totals' do
        timer_1.update(invoiced_at: Time.now)
        timer_2.update(paid_at: Time.now)

        client.calculate_totals
        expect(client.uninvoiced).to eq 0
        expect(client.uninvoiced_time).to eq 0
      end
    end

    describe '.invoiced' do
      it 'returns the invoiced time totals' do
        timer_1.update(invoiced_at: Time.now)
        timer_2.update(invoiced_at: Time.now)

        client.calculate_totals
        expect(client.invoiced).to eq 50
        expect(client.invoiced_time).to eq 250
      end

      it 'returns 0 when there are no totals' do
        timer_1.update(invoiced_at: nil)
        timer_2.update(paid_at: Time.now)

        client.calculate_totals
        expect(client.invoiced).to eq 0
        expect(client.invoiced_time).to eq 0
      end
    end

    describe '.paid time' do
      it 'returns the paid time totals' do
        timer_1.update(paid_at: Time.now)
        timer_2.update(paid_at: Time.now)

        client.calculate_totals
        expect(client.paid).to eq 50
        expect(client.paid_time).to eq 250
      end

      it 'returns 0 when there are no totals' do
        timer_1.update(paid_at: nil)
        timer_2.update(invoiced_at: Time.now)
        
        client.calculate_totals
        expect(client.paid).to eq 0
        expect(client.paid_time).to eq 0
      end
    end
  end
end
