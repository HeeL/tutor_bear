class BalanceHistory < ActiveRecord::Base

  attr_accessible :amount, :action, :user

  belongs_to :user

  validates :amount, numericality: { greater_than: 0, less_than: 10000 }, presence: true
  validates :action, inclusion: { in: %w(plus minus)}, presence: true

end