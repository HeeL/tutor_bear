class UserTeacherLearner < ActiveRecord::Migration
  def change
    add_column :users, :teach, :boolean, default: false
    add_column :users, :learn, :boolean, default: false
  end
end
