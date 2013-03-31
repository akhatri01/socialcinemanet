class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles, {:id => false} do |t|
      t.integer :pid
      t.integer :mid
      t.string :role_name

      t.timestamps
    end
    
    execute "ALTER TABLE roles ADD PRIMARY KEY (pid, mid);"
    execute "ALTER TABLE roles ADD  FOREIGN KEY(pid) REFERENCES persons(id) "
    execute "ALTER TABLE roles ADD  FOREIGN KEY(mid) REFERENCES movies(id) "
    
  end
  
  def down
    drop_table  :roles
  end
end
