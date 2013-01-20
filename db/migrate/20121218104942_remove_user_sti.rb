class RemoveUserSti < ActiveRecord::Migration

  def up
    remove_column :users, :type
    remove_column :users, :min_price
    remove_column :users, :max_price
  end

end
