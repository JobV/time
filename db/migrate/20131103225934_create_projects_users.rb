class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users, id:false do |t|
      t.belongs_to :project
      t.belongs_to :user
    end
    # add_index :projects_users, [:project_id, :user_id]
    # add_index :projects_users, :user_id
  end
end
