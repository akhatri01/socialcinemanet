class Oscar < ActiveRecord::Base
  attr_accessible :category
  
  has_many :m_nominated, :foreign_key => :oid
  has_many :oscar_movies, :through => :m_nominated, :source => :movie 
  
  has_many :p_nominated, :foreign_key => :oid
  has_many :oscar_persons, :through => :p_nominated, :source => :movie 
  
  def winners
    @movies = Movie.find_by_sql ["(SELECT m.* FROM movies m, p_nominated p_o WHERE (p_o.oid = ? AND p_o.mid = m.id AND p_o.win = 1) AND m.name IS NOT null AND m.name <> '' GROUP BY m.id ORDER BY p_o.year) UNION (SELECT m.* FROM movies m, m_nominated m_o WHERE (m_o.oid = ? AND m_o.mid = m.id AND m_o.win = 1) AND m.name IS NOT null AND m.name <> '' GROUP BY m.id ORDER BY m_o.year)", self.id, self.id]
  end
end
