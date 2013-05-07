class AddAggregateTableForURatings < ActiveRecord::Migration
  def up
    execute "CREATE TABLE aggregate_u_ratings_for_movies AS (SELECT mid, AVG(rating) as average, COUNT(rating) as count FROM u_ratings GROUP BY mid)"
    execute "create index average_index_aggregate_u_ratings_for_movies on aggregate_u_ratings_for_movies (average)"
    execute "create index count_index_aggregate_u_ratings_for_movies on aggregate_u_ratings_for_movies (count)"
  end

  def down
    execute "DROP TABLE aggregate_u_ratings_for_movies"
  end
end
