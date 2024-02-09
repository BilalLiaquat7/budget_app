class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_transactions
  has_many budget_transactions, through: :group_transactions

  validates :name, presence: true
  validates :icon, presence: true
end
