class Timer < ActiveRecord::Base
  belongs_to :project

  def time
    end_time? ? end_time - created_at : Time.now - created_at
  end
  alias_method :length, :time

  def stop(time = Time.now)
    end_time = time
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
end
