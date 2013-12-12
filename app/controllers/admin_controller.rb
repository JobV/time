class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :current_user_is_admin?

  def index
    @user_count    = User.count
    @timer_count   = Timer.count
    @project_count = Project.count
  end

  def add_admin
    user = User.find_by(email:params[:email])
    user.update(admin: true) if user
    redirect_to admin_path
  end

  private

  def current_user_is_admin?
    redirect_to timers_path unless current_user.admin
  end
end
