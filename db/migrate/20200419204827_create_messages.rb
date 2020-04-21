class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages, id: :uuid do |t|
      t.belongs_to :conversation, type: :uuid, null: false, foreign_key: true
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
