require 'spec_helper'

describe TimersController do
  include Devise::TestHelpers
  before     { FactoryGirl.create_list(:timer, 10) }
  let(:user) { FactoryGirl.create(:user) }

  context 'not signed in' do
    it '#index' do
      get :index
      expect_redirect
    end
    it '#show' do
      get :show, id: 1
      expect_redirect
    end
    it '#create' do
      post :create
      expect_redirect
    end
    it '#update' do
      patch :update, id: 1
      expect_redirect
    end
    it '#destroy' do
      post :destroy, id: 1
      expect_redirect
    end
  end

  context 'signed in' do
    before(:each) { sign_in user }
    describe '#index' do
      before  { get :index, format: :json }
      specify { expect_success }
    end
    describe '#show' do
      before  { get :show, id: 1, format: :json }
      specify { expect_success }
    end
    describe '#create' do
      before  { post :create, timer: {}, format: :json}
      specify { expect_success }
    end
    describe '#update' do
      before  { patch :update, id: 1, timer: {}, format: :json }
      specify { expect_success }
    end
    describe '#destroy' do
      before  { delete :destroy, id: 1, format: :json }
      specify { expect_success }
    end
  end
end
