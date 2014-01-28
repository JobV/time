class AddValuesToClient < ActiveRecord::Migration
  def change
    add_column :clients, :uninvoiced, :integer
    add_column :clients, :uninvoiced_time, :integer
    add_column :clients, :invoiced, :integer
    add_column :clients, :invoiced_time, :integer
    add_column :clients, :paid, :integer
    add_column :clients, :paid_time, :integer
  end
end
