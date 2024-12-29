class ChangeForeignKeysToCascade < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :posts, :users
    add_foreign_key :posts, :users, on_delete: :cascade

    remove_foreign_key :likes, :users
    add_foreign_key :likes, :users, on_delete: :cascade

    remove_foreign_key :likes, :posts
    add_foreign_key :likes, :posts, on_delete: :cascade

    remove_foreign_key :saved_posts, :users
    add_foreign_key :saved_posts, :users, on_delete: :cascade

    remove_foreign_key :saved_posts, :posts
    add_foreign_key :saved_posts, :posts, on_delete: :cascade
  end
end
