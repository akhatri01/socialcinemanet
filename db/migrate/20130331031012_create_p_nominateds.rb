class CreatePNominateds < ActiveRecord::Migration
  def up
    create_table :p_nominated,{:id => false} do |t|
      t.integer :oid
      t.integer :pid
      t.integer :mid
      t.integer :year
      t.boolean :win

      t.timestamps
      
    end
     execute "ALTER TABLE p_nominated ADD PRIMARY KEY (oid, pid, mid, year);"
      execute "ALTER TABLE p_nominated ADD  FOREIGN KEY(oid) REFERENCES oscars(id); "
      execute "ALTER TABLE p_nominated ADD  FOREIGN KEY(pid) REFERENCES persons(id); "
      execute "ALTER TABLE p_nominated ADD  FOREIGN KEY(mid) REFERENCES movies(id); "
  end
  
  def down
    drop_table  :p_nominated
  end
  
end
