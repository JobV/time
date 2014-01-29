module TimerTotals
  extend ActiveSupport::Concern

  def calculate_totals
    update(
      uninvoiced:       calc_uninvoiced_value,
      uninvoiced_time:  calc_uninvoiced_time,
      invoiced:         calc_invoiced_value,
      invoiced_time:    calc_invoiced_time,
      paid:             calc_paid_value,
      paid_time:        calc_paid_time
      )
  end

  #
  ## UNINVOICED
  #
  def uninvoiced!
    update(uninvoiced: calc_uninvoiced_value)
  end

  def uninvoiced_time!
    update(uninvoiced_time: calc_uninvoiced_time)
  end

  #
  ## INVOICED
  #
  def invoiced!
    update(invoiced: calc_invoiced_value)
  end

  def invoiced_time!
    update(invoiced_time: calc_invoiced_time)
  end

  #
  ## PAID
  #
  def paid!
    update(paid: calc_paid_value)
  end

  def paid_time!
    update(paid: calc_paid_time)
  end

  private

  def calc_uninvoiced_time
    timers ? timers.where(invoiced_at: nil, paid_at: nil).sum(:total_time) : 0
  end

  def calc_uninvoiced_value
    timers ? timers.where(invoiced_at: nil, paid_at: nil).sum(:total_value) : 0
  end

  def calc_invoiced_time
    timers ? timers.where.not(invoiced_at: nil).where(paid_at: nil).sum(:total_time) : 0
  end

  def calc_invoiced_value
    timers ? timers.where.not(invoiced_at: nil).where(paid_at: nil).sum(:total_value) : 0
  end

  def calc_paid_time
    timers ? timers.where.not(paid_at: nil).sum(:total_time) : 0
  end

  def calc_paid_value
    timers ? timers.where.not(paid_at: nil).sum(:total_value) : 0
  end
end
