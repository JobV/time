require 'test_helper'
include Devise::TestHelpers

class ProjectsControllerTest < ActionController::TestCase
  include Rails.application.routes.url_helpers

  def setup
    FactoryGirl.factories.clear
    FactoryGirl.find_definitions
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  test '#index reponds with users projects' do
    get :index
    assert_response :success
    assert_not_nil assigns @projects
  end

  test '#create' do
    post :create, project: {name: 'JX-Time'}
    assert_response 302
    assert_equal "New project made.", flash[:notice] 
    assert_equal 1, Project.count
  end

  test '#show' do
    FactoryGirl.create(:project)
    get :show, id: 1
    assert_response 200
  end

  test '#destroy' do
    FactoryGirl.create(:project)
    post :destroy, id: 1
    assert_response 302
    assert_equal "Your project has been deleted.", flash[:notice]
  end

  test '#edit' do
    FactoryGirl.create(:project)
    get :edit, id: 1
    assert_response 200
  end

  # TODO test when it goes wrong
  test '#update' do
    FactoryGirl.create(:project)
    patch :update, id: 1, project: { name: "Hello!" }
    assert_response 302
    assert_equal "Your project has been updated.", flash[:notice]
    assert_equal "Hello!", Project.find(1).name
  end

  private

  def login(user)
    sign_in(user)
    assert_response 200
  end
end
