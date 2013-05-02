class Movie < ActiveRecord::Base
  attr_accessible :imdb_rating, :length, :name, :release_date
  
  has_many :u_ratings, :foreign_key => :mid
  has_many :users_rated, :through => :u_ratings, :source => :user
  
  def user_rating
    sum = 0
    cnt = 0
    self.u_ratings.each do |u_rating|
      sum += u_rating.rating
      cnt += 1
    end
    if cnt > 0
      return sum / cnt
    else
      return nil
    end
  end
  
  def self.movie_tables(idx, sort_by)
    if sort_by == 'year'
      Movie.find_by_sql [
        "SELECT * 
        FROM movies 
        WHERE name <> '' 
        AND name IS NOT null 
        ORDER BY YEAR(release_date), name 
        LIMIT ?,?", 
        (idx-1)*20, 20
      ]
    elsif sort_by == 'imdb_rating'
      Movie.find_by_sql [
        "SELECT * 
        FROM movies 
        WHERE name <> '' 
        AND name IS NOT null 
        ORDER BY imdb_rating DESC, name 
        LIMIT ?,?", 
        (idx-1)*20, 20
      ]
    elsif sort_by == 'genre'
      Movie.find_by_sql [
        "SELECT * 
        FROM movies 
        WHERE name <> '' 
        AND name IS NOT null 
        ORDER BY imdb_rating DESC, name 
        LIMIT ?,?", 
        (idx-1)*20, 20
      ]
    else
      Movie.find_by_sql [
        "SELECT * 
        FROM movies 
        WHERE name <> '' 
        AND name IS NOT null 
        ORDER BY name 
        LIMIT ?,?", 
        (idx-1)*20, 20
      ]
    end
  end
  
  def genre
    Genre.find_by_sql ["SELECT g.* FROM genres g JOIN classifieds c ON c.gid = g.id AND c.mid = ?", self.id]
  end
end
