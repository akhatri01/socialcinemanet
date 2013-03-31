class CreateOscars < ActiveRecord::Migration
  def up
    create_table :oscars do |t|
      t.string :category

      t.timestamps
    end
  end
  
  def down
    drop_table :oscars
  end
  
end
