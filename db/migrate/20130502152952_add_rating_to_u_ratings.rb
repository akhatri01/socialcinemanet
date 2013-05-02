class AddRatingToURatings < ActiveRecord::Migration
  def change
    add_column :u_ratings, :rating, :float
    change_column :u_ratings, :uid, :integer
    change_column :u_ratings, :mid, :integer
    
  end
end
