class AddValuesToProject < ActiveRecord::Migration
  def change
    add_column :projects, :uninvoiced, :integer
    add_column :projects, :uninvoiced_time, :integer
    add_column :projects, :invoiced, :integer
    add_column :projects, :invoiced_time, :integer
    add_column :projects, :paid, :integer
    add_column :projects, :paid_time, :integer
  end
end
