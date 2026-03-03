class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.string :work_name, null: false
      t.integer :category, null: false, default: 0
      t.boolean :is_public, null: false, default: true

      t.timestamps  # created_at, updated_at を自動作成
    end

    add_index :posts, :category
    add_index :posts, :is_public
  end
end