class Timer < ActiveRecord::Base
  belongs_to :project
  has_many :moments

  def time
    moments.map(&:time).reduce(:+).to_i
  end
  alias_method :length, :time

  def start
    if running?
      if moments.last.time > 3.seconds
        moments.last.stop
        moments.create
      end
    else
      moments.create
    end
  end

  def stop(time = Time.now)
    moments.last.stop(time) if moments.last
  end
  alias_method :pause, :stop

  def running?
    moments.last ? moments.last.running? : false
  end

  def stopped?
    !running?
  end
  alias_method :done?, :stopped?
end
