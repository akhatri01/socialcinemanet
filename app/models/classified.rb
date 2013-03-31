class Classified < ActiveRecord::Base
  attr_accessible :gid, :mid
  
  set_table_name 'classified'
end
