class CreateClassifieds < ActiveRecord::Migration
  def up
    create_table :classifieds, {:id => false} do |t|
      t.integer :mid
      t.integer :gid

      t.timestamps
    end
    execute 'ALTER TABLE classifieds ADD PRIMARY KEY (mid, gid);'
    execute 'ALTER TABLE classifieds ADD FOREIGN KEY (mid) REFERENCES movies(id);'
    execute 'ALTER TABLE classifieds ADD FOREIGN KEY (gid) REFERENCES genres(id);'
  end
  
  def down
    drop_table :classifieds
  end

end
