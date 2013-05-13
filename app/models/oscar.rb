class Oscar < ActiveRecord::Base
  attr_accessible :category
  
  has_many :m_nominated, :foreign_key => :oid
  has_many :oscar_movies, :through => :m_nominated, :source => :movie 
end
