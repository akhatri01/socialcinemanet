class CreateTopUsers < ActiveRecord::Migration
  def change
    create_table :top_users,{:id => false} do |t|
      t.uid  :integer
      t.date :nomination_date
    end
  end
end
