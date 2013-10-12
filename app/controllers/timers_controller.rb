class TimersController < ApplicationController
  respond_to :html
  # before_filter :authenticate_user!

  def index
    @timers = Timer.all
  end

  def start
    @timer = Timer.create
    @timer.start
    redirect_to timers_path
  end

  def stop
    @moment = Timer.last.moments.last
    @moment.stop
    @moment.save
    redirect_to timers_path
  end
end

