class AddPlotToMovies < ActiveRecord::Migration
  def up
    add_column :movies, :plot, :text
  end
  
  def down
    remove_column :movies, :plot
  end
end
