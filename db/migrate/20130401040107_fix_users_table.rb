class FixUsersTable < ActiveRecord::Migration
  def up
      execute 'alter table users add unique index email_constraint (email);'
  end

  def down
      execute 'alter table users drop index email_constraint;'
  end
end
