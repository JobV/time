class AddActivityToTimer < ActiveRecord::Migration
  def change
    add_column :timers, :activity, :string
  end
end
