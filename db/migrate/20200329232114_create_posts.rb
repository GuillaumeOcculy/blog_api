class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true, index: true
      t.text :body

      t.timestamps
    end
  end
end
