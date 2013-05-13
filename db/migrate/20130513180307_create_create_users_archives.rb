class CreateCreateUsersArchives < ActiveRecord::Migration
    def up
    create_table :users_archive, {:id => false} do |t|
	  t.integer :id
      t.string :fname
      t.string :mname
      t.string :lname
      t.datetime :dob
      t.string :email
      t.string :password
      t.boolean :is_admin
	  t.datetime :created_at
	  t.datetime :updated_at
    end
  end
  
  def down
    drop_table :users_archive
  end
end
