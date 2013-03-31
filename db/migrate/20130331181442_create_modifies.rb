class CreateModifies < ActiveRecord::Migration
  def up
    create_table :u_modify, {:id => false} do |t|
      t.integer :uid
      t.integer :mid
      t.string :action
      t.string :data

      t.timestamps
    end
    execute 'ALTER TABLE u_modify ADD PRIMARY KEY (uid, mid);'
    execute 'ALTER TABLE u_modify ADD FOREIGN KEY (uid) REFERENCES users(id);'
    execute 'ALTER TABLE u_modify ADD FOREIGN KEY (mid) REFERENCES movies(id);'
  end
  def down
    drop_table :u_modify
  end
end
