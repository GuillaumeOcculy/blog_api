class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true
      t.uuid :friend_id, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :friendships, [:user_id, :friend_id]
  end
end
