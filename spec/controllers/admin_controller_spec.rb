require 'spec_helper'

#
# TODO everything in shared examples. Three contexts. Everything that is not admin should redirect.
#

describe AdminController do
  include Devise::TestHelpers
  let(:user) { FactoryGirl.build(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  describe '#index' do
    context 'not signed in' do
      before { get :index }
      specify { expect(response).to be_redirect }
    end

    context 'not an admin' do
      before do
        sign_in user
        get :index
      end
      specify { expect(response).to be_redirect }
    end

    context 'admin' do
      before do
        sign_in admin
        get :index
      end
      specify { expect(response).to be_success }
    end
  end

  describe '#add_admin' do
    let(:existing_user) { FactoryGirl.create(:user) }
    before do 
      sign_in admin
      post :add_admin, user: { email: existing_user.email }
    end
    specify { expect(User.last.admin).to be true }
  end
end
