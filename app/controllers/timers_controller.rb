class TimersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, :html

  def index
    @new_timer = Timer.new
    @timers         = current_user.timers.includes(:project)
    @projects       = current_user.projects
    @release_notes  = `git log --color --pretty=format:'(%cr) %s ;' --abbrev-commit -8`.split(";")
    respond_with @timers, root: false
  end

  def show
    respond_with find_timer_by_id
  end

  def create
    total_time  = ChronicDuration.parse(params[:written_time]) if params[:written_time]
    project     = current_user.projects.find_or_create_by(name: params[:project_name]) if params[:project_name]
    total_value = calculate_total_value(total_time, project.hourly_rate)
    respond_with current_user.timers.create(
      end_time:     params[:end_time], 
      project_id:   project.id, 
      total_time:   total_time, 
      total_value:  total_value)
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

  def calculate_total_value(time_in_seconds, hourly_rate)
    return 0 unless hourly_rate or time_in_seconds
    sec_rate = hourly_rate.to_f / 60 / 60
    return sec_rate * time_in_seconds
  end

  def find_timer_by_id
    Timer.find_by(id: params[:id])
  end

  def timer_params
    params.permit(:end_time, :user_id, :project_id)
  end
end
