class ClientsUsers < ActiveRecord::Migration
  def change
    create_table :clients_users, id:false do |t|
      t.belongs_to :client
      t.belongs_to :user
    end
  end
end
