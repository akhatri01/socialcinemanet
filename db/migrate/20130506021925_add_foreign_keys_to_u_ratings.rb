class AddForeignKeysToURatings < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE u_ratings ADD CONSTRAINT fk_mid_u_ratings FOREIGN KEY (mid) REFERENCES movies(id)'
    execute 'ALTER TABLE u_ratings ADD CONSTRAINT fk_uid_u_ratings FOREIGN KEY (uid) REFERENCES users(id)'
  end
end
