class Timer < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  attr_reader :written_time

  # Deprecate ASAP
  def time
    end_time? ? end_time - created_at : Time.now - created_at
  end
  alias_method :length, :time

  def stop
    end_time_will_change!
    self.end_time = Time.now
    set_total_time
    save!
  end
  alias_method :pause, :stop

  def running?
    !end_time?
  end

  def stopped?
    !running?
  end

  def state
    running? ? 'running' : 'stopped'
  end

  def set_total_time
    total_time_will_change!
    self.total_time = (self.end_time - created_at).floor
  end
end
