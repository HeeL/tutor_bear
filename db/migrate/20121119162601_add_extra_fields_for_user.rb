class AddExtraFieldsForUser < ActiveRecord::Migration
  def change
    add_column :users, :type,      :string,  default: 'Learner'
    add_column :users, :min_price, :integer, default: 0
    add_column :users, :max_price, :integer, default: 0
    add_column :users, :active,    :boolean, default: true
  end
end
