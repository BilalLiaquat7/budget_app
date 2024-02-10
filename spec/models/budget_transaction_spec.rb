require 'rails_helper'

RSpec.describe BudgetTransaction, type: :model do
  before(:each) do
    @user = User.create(name: 'hamid', email: 'hdm@gmail.com', password: '123456', password_confirmation: '123456',
                        id: 1)
    @budget_transacton = BudgetTransaction.create(name: 'test', amount: 23, author_id: @user.id)
  end

  it 'is invalid without name' do
    @budget_transacton.name = nil
    expect(@budget_transacton).not_to be_valid
  end

  it 'is invalid without author' do
    @budget_transacton.author = nil
    expect(@budget_transacton).not_to be_valid
  end

  it 'is invalid without amount' do
    @budget_transacton.amount = nil
    expect(@budget_transacton).not_to be_valid
  end

  it 'is invalid if amount is negative' do
    @budget_transacton.amount = -2
    expect(@budget_transacton).not_to be_valid
  end

  it 'has association with the correct user' do
    expect(@budget_transacton.author.name).to eq(@user.name)
  end
end
