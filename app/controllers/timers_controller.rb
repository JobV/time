class TimersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, :html

  def index
    timers = current_user.timers.includes(:project).includes(:client)
    respond_with timers, root: false
  end

  def show
    respond_with find_timer_by_id
  end

  def create
    total_time    = ChronicDuration.parse(params[:written_time]) if params[:written_time]
    project       = current_user.projects.find_or_create_by(name: params[:project_name]) if params[:project_name]
    activity      = current_user.activities.find_or_create_by(name: params[:activity]) if params[:activity]
    total_value   = calculate_total_value(total_time, project.hourly_rate) if project
    start_time    = parse_start_time(params[:written_start_time])
    project_id    = project.id if project
    activity_name = activity.name if activity

    respond_with current_user.timers.create(
      start_time:   start_time,
      end_time:     params[:end_time], 
      project_id:   project_id, 
      total_time:   total_time, 
      total_value:  total_value,
      activity:     activity_name)
  end

  def update
    respond_with Timer.update(params[:id], params[:timer])
  end

  def destroy
    timer = find_timer_by_id
    if timer
      respond_with timer.destroy 
    else
      render json: 'ehh..'
    end
  end

  def export
    @timers = current_user.timers
    render text: @timers.to_csv
  end

  private

  def calculate_total_value(time_in_seconds, hourly_rate)
    return 0 unless hourly_rate or time_in_seconds
    sec_rate = hourly_rate.to_f / 60 / 60
    return sec_rate * time_in_seconds
  end

  def parse_start_time(start_time)
    return Time.now unless start_time
    return Chronic.parse(start_time)
  end

  def find_timer_by_id
    current_user.timers.find_by(id: params[:id])
  end

  def timer_params
    params.permit(:end_time, :user_id, :project_id)
  end
end
