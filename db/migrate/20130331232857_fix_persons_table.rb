class FixPersonsTable < ActiveRecord::Migration
  def up
    execute 'alter table persons add unique index persons_unique_constraint (fname, mname, lname);'
  end

  def down
    execute 'alter table persons drop index persons_unique_constraint;'
  end
end
