class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.datetime :end_time

      t.timestamps
    end
  end
end
