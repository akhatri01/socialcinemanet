class AddUserRatingToMovies < ActiveRecord::Migration
  def up
    add_column :movies, :user_rating, :float
    add_column :movies, :user_rating_count, :integer
    execute "UPDATE movies m LEFT JOIN (SELECT mid, AVG(rating) as average, COUNT(rating) as cnt FROM u_ratings u GROUP BY mid) res ON res.mid = m.id SET user_rating=res.average, user_rating_count=res.cnt"
    execute "create index u_rating_avg_index on movies (user_rating)"
    execute "create index u_rating_cnt_index on movies (user_rating_count)"
  end
  
  def down
    remove_column :movies, :user_rating
    remove_column :movies, :user_rating_count
  end
end
