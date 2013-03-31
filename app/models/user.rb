class User < ActiveRecord::Base
  attr_accessible :dob, :email, :fname, :is_admin, :lname, :mname, :password
end
