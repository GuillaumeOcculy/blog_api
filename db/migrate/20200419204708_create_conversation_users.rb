class CreateConversationUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :conversation_users, id: :uuid do |t|
      t.belongs_to :conversation, type: :uuid, null: false, foreign_key: true
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
