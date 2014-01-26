module TimerTotals
  extend ActiveSupport::Concern

  def uninvoiced
    uninvoiced_timers.sum(:total_value)
  end

  def uninvoiced_time
    uninvoiced_timers.sum(:total_time)
  end

  def invoiced
    invoiced_timers.sum(:total_value)
  end

  def invoiced_time
    invoiced_timers.sum(:total_time)
  end

  def paid
    paid_timers.sum(:total_value)
  end

  def paid_time
    paid_timers.sum(:total_time)
  end

  private

  def uninvoiced_timers
    timers.where(invoiced_at: nil, paid_at: nil)    
  end

  def invoiced_timers
    timers.where.not(invoiced_at: nil).where(paid_at: nil)
  end

  def paid_timers
    timers.where.not(paid_at: nil)
  end
end
