class AddProjectIdToTimer < ActiveRecord::Migration
  def change
    add_column :timers, :project_id, :integer
  end
end
