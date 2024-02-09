require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'Groups', type: :feature do
  before(:each) do
    @user = User.create(name: 'hamid', email: 'hdm@gmail.com', password: '123456', password_confirmation: '123456',
                        id: 1)
    @budget_transaction = BudgetTransaction.create(name: 'test', amount: 23, author_id: @user.id)
    @group = Group.create(author_id: @user.id, name: 'test', icon: 'http://test.com')
    @group_transaction = GroupTransaction.create(budget_transaction: @budget_transaction, group: @group)
    sign_in @user
  end

  describe 'Get /Index' do
    before(:each) do
      visit groups_path
    end
    it 'should display category details' do
      expect(page).to have_content(@group.name)
      expect(page).to have_content("Total Spendings $#{@budget_transaction.amount}")
      expect(page).to have_content(@group.created_at.strftime('%d %B %Y'))
    end

    it 'should display the text "categories in the header"' do
      within('nav') do
        expect(page).to have_content('Categories')
      end
    end

    it 'should have a link to add new category' do
      expect(page).to have_link('Add new category')
    end
  end

  describe 'Get /Show' do
    before(:each) do
      visit group_path(@group)
    end

    it 'should display details about budget transactions in the category' do
      expect(page).to have_content(@budget_transaction.name)
      expect(page).to have_content(@group_transaction.created_at.strftime('%d %B %Y'))
      expect(page).to have_content(@budget_transaction.amount)
    end

    it 'should display the text "Category" in header' do
      within('header') do
        expect(page).to have_content('Category')
      end
    end

    it 'should display buttons to add new transaction and delete category' do
      expect(page).to have_link('Add Transaction')
      expect(page).to have_button('Delete Category')
    end

    it 'clicking delete category button should delete the group' do
      group_count = Group.count
      click_button('Delete Category')
      expect(Group.count).to eq(group_count - 1)
    end
  end
end
# rubocop:enable Metrics/BlockLength
