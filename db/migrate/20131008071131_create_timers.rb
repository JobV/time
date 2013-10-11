class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.timestamps
    end
  end
end
