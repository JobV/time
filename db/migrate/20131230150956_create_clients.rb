class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :company_name
      t.text :contact_person
      t.string :kvk
      t.string :address
      t.string :postal_code

      t.timestamps
    end
  end
end
