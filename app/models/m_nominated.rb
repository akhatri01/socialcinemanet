class MNominated < ActiveRecord::Base
  attr_accessible :mid, :oid, :year
  
  set_table_name "m_nominated"
  
  
end
