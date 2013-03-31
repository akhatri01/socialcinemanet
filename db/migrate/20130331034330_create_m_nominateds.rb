class CreateMNominateds < ActiveRecord::Migration
  def up
    create_table :m_nominated,{:id => false} do |t|
      t.integer :oid
      t.integer :mid
      t.integer :year
      t.boolean :win

      t.timestamps
    end
    
    execute "ALTER TABLE m_nominated ADD PRIMARY KEY (oid, mid, year);"
      execute "ALTER TABLE m_nominated ADD  FOREIGN KEY(oid) REFERENCES oscars(id) "
      execute "ALTER TABLE m_nominated ADD  FOREIGN KEY(mid) REFERENCES movies(id) "
  end
  
  def down
    drop_table  :m_nominated
  end
  
end
