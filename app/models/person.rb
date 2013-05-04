class Person < ActiveRecord::Base
  attr_accessible :dob, :fname, :lname, :mname
  
  set_table_name 'persons'
  
  has_many :roles, :foreign_key => :pid
  has_many :movies, :through => :roles, :source => :movie
end
