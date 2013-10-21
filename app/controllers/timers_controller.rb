class TimersController < ApplicationController
  respond_to :json, :html
  # before_filter :authenticate_user!

  def index
    @timers = Timer.all
    respond_with @timers
  end

  def show
    respond_with Timer.find_by_id(params[:id])
  end

  def create
    respond_with Timer.create(params[:timer])
  end

  def update
    respond_with Timer.update(params[:id], params[:timer])
  end

  def stop
    timer = Timer.find_by_id(params[:id])
    timer.stop
    respond_with timer
  end

  def destroy
    @timer = Timer.find(params[:id])
    respond_with @timer.destroy
  end

  def starting_time
    respond_with Timer.find_by_id(params[:id]).created_at
  end
end

