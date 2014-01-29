require 'spec_helper'

describe Project do
  PROJECT_ATTRIBUTES = [
    :name, 
    :hourly_rate, 
    :uninvoiced, 
    :invoiced,
    :paid]
  
  let(:project) { FactoryGirl.create(:project) }

  PROJECT_ATTRIBUTES.each do |attr|
    specify { expect(project).to respond_to(attr) }
  end

  describe 'relationships' do
    specify { expect(project).to respond_to(:users) }
    specify { expect(project).to respond_to(:timers) }
    specify { expect(project).to respond_to(:client) }
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

        project.calculate_totals
        expect(project.uninvoiced).to eq 50
        expect(project.uninvoiced_time).to eq 250
      end

      it 'returns 0 when there are no totals' do
        timer_1.update(invoiced_at: Time.now)
        timer_2.update(paid_at: Time.now)

        project.calculate_totals
        expect(project.uninvoiced).to eq 0
        expect(project.uninvoiced_time).to eq 0
      end
    end

    describe '.invoiced' do
      it 'returns the invoiced time totals' do
        timer_1.update(invoiced_at: Time.now)
        timer_2.update(invoiced_at: Time.now)

        project.calculate_totals
        expect(project.invoiced).to eq 50
        expect(project.invoiced_time).to eq 250
      end

      it 'returns 0 when there are no totals' do
        timer_1.update(invoiced_at: nil)
        timer_2.update(paid_at: Time.now)

        project.calculate_totals
        expect(project.invoiced).to eq 0
        expect(project.invoiced_time).to eq 0
      end
    end

    describe '.paid time' do
      it 'returns the paid time totals' do
        timer_1.update(paid_at: Time.now)
        timer_2.update(paid_at: Time.now)

        project.calculate_totals
        expect(project.paid).to eq 50
        expect(project.paid_time).to eq 250
      end

      it 'returns 0 when there are no totals' do
        timer_1.update(paid_at: nil)
        timer_2.update(invoiced_at: Time.now)
        
        project.calculate_totals
        expect(project.paid).to eq 0
        expect(project.paid_time).to eq 0
      end
    end
  end
end
