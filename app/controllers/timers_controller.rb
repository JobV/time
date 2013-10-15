class TimersController < ApplicationController
  respond_to :html, :json, :js
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

  def start
    @timer = Timer.create
    @timer.start
    respond_with @timer
  end

  def stop
    @moment = Timer.last.moments.last
    @moment.stop
    @moment.save
    redirect_to timers_path
  end

  def destroy
    @timer = Timer.find(params[:id])
    @timer.destroy
    redirect_to timers_path
  end

  def starting_time
    timer =  Timer.find_by_id(params[:id])
    @starting_time = timer.created_at

    respond_with(@starting_time) do |format|
      format.json { render }
    end
  end
end

