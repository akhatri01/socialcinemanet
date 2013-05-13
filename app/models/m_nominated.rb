class MNominated < ActiveRecord::Base
  attr_accessible :mid, :oid, :year, :win
  
  set_table_name "m_nominated"
  
  belongs_to :movie, :foreign_key => :mid
  belongs_to :oscar, :foreign_key => :oid

end
