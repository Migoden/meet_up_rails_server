class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :requested_friend_id

      t.timestamps
    end

    # add_index :users, :requested_friend_id, unique: true
    add_index :friendships, [:user_id, :requested_friend_id], unique: true
  end
end
