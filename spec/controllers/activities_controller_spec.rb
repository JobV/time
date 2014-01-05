require 'spec_helper'

describe ActivitiesController do
  include Devise::TestHelpers
  let(:user)   { FactoryGirl.create(:user) }

  describe '#index' do
    before do 
      sign_in user
      FactoryGirl.create_list(:activity, 10, user_id: user.id)
      get :index, format: :json
    end
    specify { expect(response).to be_success }
    it 'returns all activities' do
      json = JSON.parse(response.body)
      expect(json.length).to eq 10 
    end
  end

  describe '#create' do

  end
end
