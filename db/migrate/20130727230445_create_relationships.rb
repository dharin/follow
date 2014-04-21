class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :Follower_id
      t.integer :Followed_id

      t.timestamps
    end
    add_index :relationships, :Follower_id
    add_index :relationships, :Followed_id
    add_index :relationships, [:Follower_id, :Followed_id], unique: true
  end
end
