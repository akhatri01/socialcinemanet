class FixMoviesTable < ActiveRecord::Migration
   def up
      execute 'alter table movies add unique index name_date_constraint (name, release_date);'
    end

    def down
      execute 'alter table movies drop index name_date_constraint;'
    end
end
