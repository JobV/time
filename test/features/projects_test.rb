require "test_helper"

class ProjectsTest < Capybara::Rails::TestCase
  def setup
    login
  end

  test "navigate to index" do
    visit root_path
    click_on "Projects"
    assert_content page,"Your projects"
  end

  test 'create a new project' do
    visit projects_path    
    fill_in :project_name, with: "JX-Time"
    click_on "Create"
    assert_content page, "JX-Time"
  end

  test 'show a project' do
    Project.create(name: "Project x1")
    visit projects_path
    click_on "Project x1"

    assert_content page, "Project x1"
    assert_content page, "Time logged in Project x1"
  end

  test 'delete a project' do
    Project.create(name: "Project x1")
    visit projects_path
    click_on "Project x1"

    click_on "Delete"

    refute_content page, "Project x1"
  end

  test 'edit a project' do
    Project.create(name: "Project y1")
    visit project_path(id: 1)

    click_on "Edit project"

    assert_content page, "Edit Project y1"
    fill_in :project_name, with: "Project z1"
    click_on "Save"

    assert_content page, "Time logged in Project z1"

    click_on "Edit project"

    fill_in :project_name, with: "Poop!"
    click_on "Cancel"

    refute_content page, "Poop!"
  end

  private

  def user
    FactoryGirl.create(:user)
  end

  def login
    visit root_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Sign in'
  end
end
