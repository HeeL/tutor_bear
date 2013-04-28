class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.date :published_at
      t.timestamps
    end
    Post.create_translation_table! title: :string, desc: :text, text: :text
  end

  def down
    drop_table :posts
    Post.drop_translation_table!
  end
end
