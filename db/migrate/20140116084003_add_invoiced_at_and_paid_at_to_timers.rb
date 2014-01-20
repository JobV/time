class AddInvoicedAtAndPaidAtToTimers < ActiveRecord::Migration
  def change
    add_column :timers, :invoiced_at, :datetime
    add_column :timers, :paid_at, :datetime
  end
end
