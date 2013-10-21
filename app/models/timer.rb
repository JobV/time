class Timer < ActiveRecord::Base
  belongs_to :project

  def time
    end_time? ? end_time - created_at : Time.now - created_at
  end
  alias_method :length, :time

  def stop
    end_time_will_change!
    self.end_time = Time.now
    set_total_time
  end
  alias_method :pause, :stop

  def running?
    !end_time?
  end

  def stopped?
    !running?
  end
  alias_method :done?, :stopped?

  def state
    running? ? 'running' : 'stopped'
  end

  # TODO make this a sidekiq task if becomes big
  def set_total_time
    total_time_will_change!
    self.total_time = (self.end_time - created_at).floor
  end
end
