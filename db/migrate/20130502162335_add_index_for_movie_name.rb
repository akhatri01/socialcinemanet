class AddIndexForMovieName < ActiveRecord::Migration
  def up
    execute 'CREATE INDEX movie_name_index ON movies (name)'
    execute 'CREATE INDEX movie_imdb_index ON movies (imdb_rating DESC, name)'
    execute 'CREATE INDEX movie_year_index ON movies (release_date, name)'
  end

  def down
    execute 'DROP INDEX movie_name_index ON movies'
    execute 'DROP INDEX movie_imdb_index ON movies'
    execute 'DROP INDEX movie_year_index ON movies'
  end
end
