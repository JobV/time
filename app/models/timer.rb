class Timer < ActiveRecord::Base
  belongs_to :project
  has_many :moments

  # Returns the total time of this timer.
  def time
    moments.map(&:time).reduce(:+).to_i
  end

  # Starts a timer.
  def start
    # check if there are any moments
    # if so, stop them if they're longer than 3 seconds
    if running?
      if moments.last.time > 3.seconds
        moments.last.stop
        moments.create
      end
    else
      moments.create
    end
  end

  # Stops a timer.
  def stop(time)
    moments.last.end_time = time
  end

  def running?
    moments.last ? moments.last.running? : false
  end

  def stopped?
    moments.last ? moments.last.ended? : true
  end
end
