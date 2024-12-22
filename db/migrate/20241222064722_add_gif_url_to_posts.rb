class AddGifUrlToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :gif_url, :string
  end
end
