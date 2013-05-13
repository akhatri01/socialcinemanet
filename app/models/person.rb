class Person < ActiveRecord::Base
  attr_accessible :dob, :fname, :lname, :mname
  
  set_table_name 'persons'
  
  has_many :roles, :foreign_key => :pid
  has_many :movies, :through => :roles, :source => :movie
  
  has_many :p_nominated, :foreign_key => :pid
  has_many :oscars,	:through => :p_nominated, :source => :oscar
end
