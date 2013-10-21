class AddTotalTimeToTimer < ActiveRecord::Migration
  def change
    add_column :timers, :total_time, :integer
  end
end
