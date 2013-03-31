class CreateRatings < ActiveRecord::Migration
  def up
    create_table :ratings, {:id => false} do |t|
      t.integer :uid
      t.integer :mid
      t.float :score

      t.timestamps
    end
    execute 'ALTER TABLE ratings ADD PRIMARY KEY (uid, mid);'
    execute 'ALTER TABLE ratings ADD FOREIGN KEY (uid) REFERENCES users(id);'
    execute 'ALTER TABLE ratings ADD FOREIGN KEY (mid) REFERENCES movies(id);'
  end
  
  def down
    drop_table :ratings
  end
end
