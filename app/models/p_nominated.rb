class PNominated < ActiveRecord::Base
  attr_accessible :mid, :oid, :pid, :year
  
  set_table_name "p_nominated"
end
