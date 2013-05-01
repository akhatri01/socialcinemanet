class Info < ActiveRecord::Base
  def self.search_movies(search_val)
    Movie.find_by_sql ["select * from movies where name like ? or year(release_date) = ? order by name limit 20;",'%'<<search_val<<'%',search_val ]    
  end
  
  def self.search_genres(search_val)
    Genre.find_by_sql ["select * from genres where category like ? order by category limit 20;",'%'<<search_val<<'%' ]    
  end
  
  def self.search_persons(search_val)
    Person.find_by_sql ["select * from persons where fname like ? or lname like ? or mname like ? order by lname limit 20;",'%'<<search_val<<'%','%'<<search_val<<'%','%'<<search_val<<'%' ]    
  end
  
  def self.search_oscars(search_val)
    Oscar.find_by_sql ["select * from oscars where category like ? order by category limit 20;",'%'<<search_val<<'%' ]    
  end
end
