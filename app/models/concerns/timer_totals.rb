module TimerTotals
  extend ActiveSupport::Concern

  def calculate_totals
    uninvoiced        = sum_uninvoiced
    uninvoiced_time   = sum_uninvoiced_time

    invoiced          = sum_invoiced
    invoiced_time     = sum_invoiced_time

    paid              = sum_paid
    paid_time         = sum_paid_time

    self.save
  end

  def sum_uninvoiced
    uninvoiced_timers.sum(:total_value)
  end

  def sum_uninvoiced_time
    uninvoiced_timers.sum(:total_time)
  end

  def sum_invoiced
    invoiced_timers.sum(:total_value)
  end

  def sum_invoiced_time
    invoiced_timers.sum(:total_time)
  end

  def sum_paid
    paid_timers.sum(:total_value)
  end

  def sum_paid_time
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
