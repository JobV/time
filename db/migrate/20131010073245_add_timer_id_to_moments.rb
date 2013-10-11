class AddTimerIdToMoments < ActiveRecord::Migration
  def change
    add_column :moments, :timer_id, :integer

    add_index :moments, :timer_id
  end
end
