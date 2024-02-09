require 'rails_helper'

RSpec.feature 'BudgetTransactions', type: :feature do
  before(:each) do
    @user = User.create(name: 'hamid', email: 'hdm@gmail.com', password: '123456', password_confirmation: '123456',
                        id: 1)
    @budget_transaction = BudgetTransaction.create(name: 'test', amount: 23, author_id: @user.id)
    @group = Group.create(author_id: @user.id, name: 'test', icon: 'http://test.com')
    @group_transaction = GroupTransaction.create(budget_transaction: @budget_transaction, group: @group)
    sign_in @user
    visit group_budget_transaction_path(@group, @budget_transaction)
  end

  context 'Get /Show' do
    it 'header should contain the text "Transaction"' do
      within('header') do
        expect(page).to have_content('Transaction')
      end
    end

    # rubocop:disable Layout/LineLength
    it 'should show details about the transaction' do
      expect(page).to have_content(@budget_transaction.name)
      expect(page).to have_content(@budget_transaction.amount)
      expect(page).to have_content("#{@budget_transaction.created_at.strftime('%d %B %Y')} At #{@budget_transaction.created_at.in_time_zone.strftime('%I:%M %p')}")
    end
    # rubocop:enable Layout/LineLength

    it 'should have a button to delete the transaction' do
      expect(page).to have_button('Delete Transaction')
    end

    it 'clicking delete transaction button should delete the transaction' do
      budget_transactions_count = BudgetTransaction.count
      click_button('Delete Transaction')
      expect(BudgetTransaction.count).to eq(budget_transactions_count - 1)
    end
  end
end
