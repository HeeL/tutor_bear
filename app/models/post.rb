class Post < ActiveRecord::Base
  attr_accessible :desc, :published_at, :text, :title
  translates :title, :desc, :text

  scope :published, where('published_at <= NOW()')

  default_scope order('published_at DESC')

  acts_as_commentable
end