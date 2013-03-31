class Person < ActiveRecord::Base
  attr_accessible :dob, :fname, :lname, :mname
  
  set_table_name 'persons'
  
end
