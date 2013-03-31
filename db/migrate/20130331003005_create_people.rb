class CreatePeople < ActiveRecord::Migration
  def up
    create_table :persons do |t|
      t.string :fname
      t.string :lname
      t.string :mname
      t.datetime :dob

      t.timestamps
    end
  end
  
  def down
      drop_table  :persons
  end
  
end
