class CreateTopUsers < ActiveRecord::Migration
  def change
    create_table :top_users,{:id => false} do |t|
      t.integer :uid
      t.date :nomination_date
    end
  end
end
