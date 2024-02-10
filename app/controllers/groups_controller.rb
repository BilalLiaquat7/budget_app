class GroupsController < ApplicationController
  def index
    @groups = Group.joins('LEFT JOIN group_transactions ON groups.id = group_transactions.group_id')
      .joins('LEFT JOIN budget_transactions ON group_transactions.budget_transaction_id = budget_transactions.id')
      .where(author_id: current_user.id)
      .select('groups.*, SUM(budget_transactions.amount) as total_amount')
      .group('groups.id')
    @header_title = 'Categories'
  end

  def show
    if Group.find_by_id(params[:id]).nil?
      redirect_to groups_path
    else
      @group = Group.includes(group_transactions: :budget_transaction).find_by_id(params[:id])
      @header_title = 'Category'
    end
  end

  def new
    @group = Group.new
    @header_title = 'New Category'
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = 'Category created Successfully'
      redirect_to groups_path
    else
      flash[:error] = @group.errors.full_messages.to_sentence
      redirect_to new_group_path
    end
  end

  def destroy
    @group = Group.find_by_id(params[:id])
    if @group.destroy
      flash[:notice] = 'Category deleted'
      redirect_to groups_path
    else
      flash[:error] = @group.errors.full_messages.to_sentence
      redirect_to request.referrer
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon).merge(author: current_user)
  end
end
