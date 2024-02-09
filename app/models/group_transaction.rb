class GroupTransaction < ApplicationRecord
  belongs_to :group
  belongs_to :budget_transaction
end
