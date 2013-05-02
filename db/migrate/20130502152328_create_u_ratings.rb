class CreateURatings < ActiveRecord::Migration
  def change
    create_table :u_ratings do |t|
      t.float :uid
      t.float :mid

      t.timestamps
    end
    execute 'alter table u_ratings add unique index unique_user_rating (uid, mid);'
  end
end
