class FixOscarsTable < ActiveRecord::Migration
  def up
    execute 'alter table oscars add unique index category_constraint (category);'
  end

  def down
    execute 'alter table oscars drop index category_constraint;'
  end
end
