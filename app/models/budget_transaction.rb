class BudgetTransaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_transactions
  has_many :groups, through: :group_transactions

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greate_than_or_equal_to: 0 }
end
