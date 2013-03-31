class CreateGenres < ActiveRecord::Migration
  def up
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end
  end
  
  def down
    drop_table :genres
  end
  
end
