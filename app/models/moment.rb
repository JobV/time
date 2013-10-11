class Moment < ActiveRecord::Base
  belongs_to :timer

  # Returns the length of the moment in seconds.
  def time
    return end_time - created_at if end_time
    return Time.now - created_at
  end

  # Returns true if the moment has ended.
  def ended?
    end_time?
  end

  # Returns true if the moment is running.
  def running?
    !end_time?
  end

  # Sets the end_time to a given parameter or Time.now.
  def stop(time = Time.now)
    self.end_time = time unless self.end_time
  end
end
