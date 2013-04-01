class MNominated < ActiveRecord::Base
  attr_accessible :mid, :oid, :year, :win
  
  set_table_name "m_nominated"
  

end
