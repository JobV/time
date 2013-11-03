require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project ||= Project.new
  end

  test 'responds' do
    assert_respond_to @project, :name
    assert_respond_to @project, :user_id
  end

  test 'validates presence of attributes' do
    p = Project.new
    assert !p.save, "Saved post without name"
  end
end
