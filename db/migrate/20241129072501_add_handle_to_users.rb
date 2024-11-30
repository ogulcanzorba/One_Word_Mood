class AddHandleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :handle, :string
  end
end
