class URating < ActiveRecord::Base
  attr_accessible :mid, :uid, :rating
  
  belongs_to :user, :foreign_key => :uid
  belongs_to :movie, :foreign_key => :mid
end
