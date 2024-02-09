class CreateGroupTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :group_transactions do |t|
      t.references :budget_transaction, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
