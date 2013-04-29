class Movie < ActiveRecord::Base
  attr_accessible :imdb_rating, :length, :name, :release_date
  
  def self.movie_tables(idx, sort_by)
    if sort_by == 'year'
      Movie.find_by_sql ["SELECT * FROM movies WHERE name <> '' AND name IS NOT null ORDER BY YEAR(release_date) LIMIT ? OFFSET ?", 20, (idx-1)*20]
    else
      Movie.find_by_sql ["SELECT * FROM movies WHERE name <> '' AND name IS NOT null ORDER BY name LIMIT ? OFFSET ?", 20, (idx-1)*20]
    end
  end
  
  def genre
    Genre.find_by_sql ["SELECT g.* FROM genres g JOIN classifieds c ON c.gid = g.id AND c.mid = ?", self.id]
  end
end
