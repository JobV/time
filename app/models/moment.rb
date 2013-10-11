class Moment < ActiveRecord::Base
  belongs_to :timer

  def time
    return end_time - created_at if end_time
    return Time.now - created_at
  end
  alias_method :length, :time

  def ended?
    end_time?
  end
  alias_method :done?, :ended?

  def running?
    !end_time?
  end

  def stop(time = Time.now)
    self.end_time = time unless self.end_time
  end
  alias_method :pause, :stop
end
