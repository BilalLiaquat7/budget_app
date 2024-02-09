require 'rails_helper'

RSpec.describe GroupTransaction, type: :model do
  before(:each) do
    @user = User.create(name: 'bilal', email: 'bilal@gmail.com', password: '123456', password_confirmation: '123456',
                        id: 1)
    @budget_transacton = BudgetTransaction.create(name: 'test', amount: 123, author_id: @user.id)
    @group = Group.create(author_id: @user.id, name: 'test', icon: 'http//:test.com')
    @group_transaction = GroupTransaction.create(budget_transaction: @budget_transacton, group: @group)
  end

  it 'is deleted if group is deleted' do
    expect(GroupTransaction.count).to eq(1)
    @group.destroy
    expect(GroupTransaction.count).to eq(0)
  end

  it 'after destroy, deletes all budget_transactions that does not have association in group_transaction' do
    expect(BudgetTransaction.count).to eq(1)
    @group_transaction.destroy
    expect(BudgetTransaction.count).to eq(0)
  end

  it 'is invalid without group_id' do
    @group_transaction.group = nil
    expect(@group_transaction).not_to be_valid
  end

  it 'is invalid without budget_transaction_id' do
    @group_transaction.budget_transaction = nil
    expect(@group_transaction).not_to be_valid
  end
end
