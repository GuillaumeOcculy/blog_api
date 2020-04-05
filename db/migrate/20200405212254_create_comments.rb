class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :commentable, type: :uuid, polymorphic: true, null: false
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
