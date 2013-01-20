class DropLanguagesUsers < ActiveRecord::Migration
  def up
    drop_table :languages_users
  end
end
