class Classified < ActiveRecord::Base
  attr_accessible :gid, :mid
  
  belongs_to :movie, :foreign_key => :mid
  belongs_to :genre, :foreign_key => :gid
  
end
