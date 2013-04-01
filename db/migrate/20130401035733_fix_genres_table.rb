class FixGenresTable < ActiveRecord::Migration
  def up
      execute 'alter table genres add unique index name (name);'
  end

  def down
      execute 'alter table movies drop index name;'
  end
end
