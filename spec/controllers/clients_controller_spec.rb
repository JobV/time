require 'spec_helper'


describe ClientsController do
  include Devise::TestHelpers
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'index' do
    before  do
      5.times do
        client = FactoryGirl.create(:client)
        client.users << user
      end
      get :index, format: :json
    end

    specify { expect(response).to be_success }

    it 'returns all clients of the user' do
      json = JSON.parse(response.body)
      expect(json.length).to eq 5
    end
  end

  describe 'create' do
    it 'responds' do
      post :create, format: :json, client: { company_name: 'JAXONS' }
      expect(response).to be_success
    end

    it 'gives an error message if the validations are not met' do
      post :create, format: :json, client: { company_name: '' }
      # expect(response).to be_bad_request
    end
  end

  describe 'update' do
    before do 
      client = FactoryGirl.create(:client)
      client.users << user
    end

    it 'responds' do
      patch :update, format: :json, client: { company_name: "Apple" }, id: 1
      expect(response).to be_success
    end
  end
end

