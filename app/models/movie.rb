class Movie < ActiveRecord::Base
  attr_accessible :imdb_rating, :length, :name, :release_date
  
  has_many :u_ratings, :foreign_key => :mid
  has_many :users_rated, :through => :u_ratings, :source => :user
  
  has_many :roles, :foreign_key => :mid
  has_many :persons, :through => :roles, :source => :person
  
  has_many :m_nominated, :foreign_key => :mid
  has_many :movie_oscars, :through => :m_nominated, :source => :oscar
  
  has_many :p_nominated, :foreign_key => :mid
  has_many :person_oscars, :through => :p_nominated, :source => :oscar
  
  has_many :classifieds, :foreign_key => :mid
  has_many :genres, :through => :classifieds, :source => :genre
  
  def self.top_250
    # Movie.find_by_sql ["SELECT *, AVERAGE(u.rating) FROM movies FORCE INDEX (movie_name_index) JOIN u_ratings u ON u.mid = movies.id WHERE name <> '' AND name IS NOT null LIMIT 10"]
  end
  
  def user_rating
    sum = 0
    cnt = 0
    self.u_ratings.each do |u_rating|
      sum += (u_rating.rating || 0)
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
        FROM movies FORCE INDEX (movie_year_index)
        WHERE name <> '' 
        AND name IS NOT null 
        ORDER BY YEAR(release_date), name 
        LIMIT ?,?", 
        (idx-1)*20, 20
      ]
    elsif sort_by == 'imdb_rating'
      Movie.find_by_sql [
        "SELECT * 
        FROM movies FORCE INDEX (movie_imdb_index)
        WHERE name <> '' 
        AND name IS NOT null 
        AND imdb_rating IS NOT null
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
    elsif sort_by == 'user_rating'
      Movie.find_by_sql [
        "SELECT m.* " +
        "FROM movies m " + 
        "WHERE m.name IS NOT null " + 
        "AND m.name <> '' " + 
        "ORDER BY user_rating DESC, user_rating_count DESC, m.name " + 
        "LIMIT ?,?", 
        (idx-1)*20, 20
      ]
    elsif sort_by == 'user_rating_number'
      Movie.find_by_sql [
        "SELECT m.* " +
        "FROM movies m " + 
        "WHERE m.name IS NOT null " + 
        "AND m.name <> '' " + 
        "ORDER BY user_rating_count DESC, user_rating DESC, m.name " + 
        "LIMIT ?,?", 
        (idx-1)*20, 20
      ]
    else
      Movie.find_by_sql [
        "SELECT * 
        FROM movies FORCE INDEX (movie_name_index)
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
