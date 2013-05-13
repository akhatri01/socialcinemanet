class AddIndexToURatings < ActiveRecord::Migration
  def up
	    execute 'CREATE INDEX updated_at_index ON u_ratings (updated_at)'
  end
  
  def down
	execute 'DROP INDEX updated_at_index on u_ratings'
  end
end
