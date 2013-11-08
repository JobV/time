class TimersController < ApplicationController
  respond_to :json, :html
  before_filter :authenticate_user!

  def index
    @timers = Timer.where(user_id: current_user.id)
    @release_notes = `git log --color --pretty=format:'(%cr) %s' --abbrev-commit -1`
    respond_with @timers
  end

  def show
    respond_with Timer.find_by(id: params[:id])
  end

  def create
    respond_with Timer.create(end_time: params[:end_time], user_id: current_user.id)
  end

  def update
    respond_with Timer.update(params[:id], params[:timer])
  end

  def stop
    timer = Timer.find_by(id: params[:id])
    timer.stop
    respond_with timer
  end

  def destroy
    @timer = Timer.find_by(id: params[:id])
    respond_with @timer.destroy
  end

  def starting_time
    respond_with Timer.find_by(id: params[:id]).created_at
  end

  private

  def timer_params
    params.permit(:end_time, :user_id)
  end
end
