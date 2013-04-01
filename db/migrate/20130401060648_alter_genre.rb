class AlterGenre < ActiveRecord::Migration
  def up
      execute "ALTER TABLE genres CHANGE name category varchar(255);"
  end

  def down
    execute "ALTER TABLE genres CHANGE category name varchar(255);"
  end
end
