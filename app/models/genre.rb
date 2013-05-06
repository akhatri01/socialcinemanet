class Genre < ActiveRecord::Base
  attr_accessible :category
  
  has_many :classifieds, :foreign_key => :gid
  has_many :movies, :through => :classifieds, :source => :movie
end
