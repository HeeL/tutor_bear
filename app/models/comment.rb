class Comment < ActiveRecord::Base
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  validates :text, presence: true
  validates :name, presence: true

  attr_accessible :text, :commentable, :name, :parent_id, :locale

  belongs_to :commentable, polymorphic: true

  default_scope order('created_at ASC')

  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  def has_children?
    self.children.any?
  end

  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end
end
