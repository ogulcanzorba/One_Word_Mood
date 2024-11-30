class AddMoodWordToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :mood_word, :string
  end
end
