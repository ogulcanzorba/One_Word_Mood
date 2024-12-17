class AddViewsCountToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :views_count, :integer
  end
end
