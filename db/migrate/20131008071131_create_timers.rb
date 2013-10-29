class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.datetime :end_time
      t.timestamps
    end
  end
end
