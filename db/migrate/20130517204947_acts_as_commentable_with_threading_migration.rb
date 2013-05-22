class ActsAsCommentableWithThreadingMigration < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.integer :commentable_id, :default => 0
      t.string :commentable_type, :default => ""
      t.string :name, :default => ""
      t.text :text, :default => ""
      t.integer :parent_id, :lft, :rgt
      t.string :locale
      t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type]
  end
  
  def self.down
    drop_table :comments
  end
end
