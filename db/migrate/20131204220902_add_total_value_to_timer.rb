class AddTotalValueToTimer < ActiveRecord::Migration
  def change
    add_column :timers, :total_value, :integer
  end
end
