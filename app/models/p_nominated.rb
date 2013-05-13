class PNominated < ActiveRecord::Base
  attr_accessible :mid, :oid, :pid, :year, :win
  
  set_table_name "p_nominated"
  
  belongs_to :movie, :foreign_key => :mid
  belongs_to :oscar, :foreign_key => :oid
  belongs_to :person, :foreign_key => :pid
end
