class Role < ActiveRecord::Base
  attr_accessible :mid, :pid, :role_name
  
  belongs_to :movie, :foreign_key => :mid
  belongs_to :person, :foreign_key => :pid
end
