class Modify < ActiveRecord::Base
  attr_accessible :action, :data, :mid, :uid
  
  set_table_name 'u_modify'
end
