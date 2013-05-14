class CreateUsersArchive < ActiveRecord::Base
  # attr_accessible :dob, :email, :fname, :is_admin, :lname, :mname, :password
  
  set_table_name 'users_archive'
end
