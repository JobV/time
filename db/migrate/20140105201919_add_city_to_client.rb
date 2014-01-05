class AddCityToClient < ActiveRecord::Migration
  def change
    add_column :clients, :city, :string
  end
end
