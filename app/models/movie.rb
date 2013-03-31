class Movie < ActiveRecord::Base
  attr_accessible :imdb_rating, :length, :name, :release_date
end
