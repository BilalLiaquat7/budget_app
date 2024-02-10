class GroupTransaction < ApplicationRecord
  belongs_to :group
  belongs_to :budget_transaction
  after_destroy :destroy_orphaned_budget_transaction

  def destroy_orphaned_budget_transaction
    budget_transaction.destroy if budget_transaction.group_transactions.empty?
  end
end
