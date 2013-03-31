class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string :name
      t.datetime :release_date
      t.float :imdb_rating
      t.integer :length

      t.timestamps
    end
  end
  
  def down
    drop_table :movies
  end
  
end
