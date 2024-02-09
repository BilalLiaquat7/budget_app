class CreateBudgetTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :budget_transactions do |t|
      t.string :name
      t.float :amount

      t.timestamps
    end
  end
end
