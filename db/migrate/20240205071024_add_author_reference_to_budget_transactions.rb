class AddAuthorReferenceToBudgetTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :budget_transactions, :author, null: false, foreign_key: { to_table: :users }
  end
end
