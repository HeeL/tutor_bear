class Teacher < ActiveRecord::Base

  attr_accessible :min_price, :max_price, :languages

  belongs_to :user
  has_and_belongs_to_many :languages

  validates :min_price, numericality: { greater_than_or_equal_to: 0, less_than: 100 },
                        presence: true                   
  validates :max_price, numericality: { greater_than_or_equal_to: :min_price, less_than: 100 },
                        presence: true
end