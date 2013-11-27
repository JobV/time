class TimersController < ApplicationController
  respond_to :json, :html
  before_filter :authenticate_user!

  def index
    @new_timer = Timer.new
    @timers = Timer.where(user_id: current_user.id)
    @release_notes = `git log --color --pretty=format:'(%cr) %s' --abbrev-commit -1`
    respond_with @timers
  end

  def show
    respond_with find_timer_by_id
  end

  def create
    respond_with Timer.create(end_time: params[:end_time], project_id: params[:project_id], user_id: current_user.id)
  end

  def update
    respond_with Timer.update(params[:id], params[:timer])
  end

  def stop
    timer = find_timer_by_id
    timer.stop
    respond_with timer
  end

  def destroy
    @timer = find_timer_by_id
    respond_with @timer.destroy
  end

  def starting_time
    respond_with find_timer_by_id.created_at
  end

  private

  def find_timer_by_id
    Timer.find_by(id: params[:id])
  end

  def timer_params
    params.permit(:end_time, :user_id, :project_id)
  end
end
