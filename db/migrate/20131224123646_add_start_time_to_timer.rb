class AddStartTimeToTimer < ActiveRecord::Migration
  def change
    add_column :timers, :start_time, :datetime
  end
end
