namespace :parse do
  
  desc "Generate fake user votes."
  # run 'rake parse:add_ratings
  task :fake_user_votes => :environment do
    # ActiveRecord::Base.transaction do
    #   1000000.times do |idx|
    #     if idx % 50 == 0 then puts "added " + idx.to_s + " votes" end
    #     user_id = User.offset(rand(total_users)).first.id
    #     movie_id =  Movie.where("name is not null and name <> ''").offset(rand(total_movies)).first.id
    #     u_rating = URating.new
    #     u_rating.uid = user_id
    #     u_rating.mid = movie_id
    #     rating = ((rand * 10) % 10).round 1
    #     u_rating.save
    #   end
    # end
    users = User.all
    # movies = Movie.find_by_sql ["select id from movies WHERE (name is not null and name <> '')"]
    movies_query_result = ActiveRecord::Base.connection.execute "select id from movies WHERE (name is not null and name <> '')"
    movies = []
    movies_query_result.each do |result|
      movies.push(result[0])
    end
    total_users = users.size
    total_movies = movies.size
    inserts = []
    1000000.times do |idx|
      if idx % 100000 == 0 then puts "added " + idx.to_s + " votes" end
      # user_id = User.offset(rand(total_users)).first.id
      # movie_id =  Movie.where("name is not null and name <> ''").offset(rand(total_movies)).first.id
      user_id = users[rand(total_users)].id
      movie_id = movies[rand(total_movies)]
      inserts.push "(" + 
        user_id.to_s + "," +  
        movie_id.to_s + "," + 
        ((rand * 10) % 10).round(1).to_s + "," +
        "'" + Date.today.to_s(:db) + "'" + "," +
        "'" + Date.today.to_s(:db) + "'" +
      ")"
      if idx % 10000 == 0 && idx != 0
        ActiveRecord::Base.connection.execute "INSERT INTO u_ratings (uid, mid, rating, created_at, updated_at) VALUES #{inserts.join(", ")} ON DUPLICATE KEY UPDATE uid = VALUES(uid), mid = VALUES(mid), rating = VALUES(rating), created_at = now(), updated_at = now()"
        inserts = []
      end
    end
  end
end