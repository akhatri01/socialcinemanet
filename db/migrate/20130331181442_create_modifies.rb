class CreateModifies < ActiveRecord::Migration
  def up
    create_table :modifies do |t|
      t.integer :uid
      t.integer :mid
      t.string :action
      t.string :data

      t.timestamps
    end
  end
  def down
    drop_table :modifies
  end
end
