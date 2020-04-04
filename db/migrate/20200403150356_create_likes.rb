class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes, id: :uuid do |t|
      t.references :likeable, type: :uuid, polymorphic: true, null: false
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
