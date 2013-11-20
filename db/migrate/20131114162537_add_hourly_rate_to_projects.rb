class AddHourlyRateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hourly_rate, :integer
  end
end
