class BudgetTransactionsController < ApplicationController
  def show
    @budget_transaction = BudgetTransaction.find_by_id(params[:id])
    @group = Group.find_by_id(params[:group_id])
    if @budget_transaction.nil?
      redirect_to group_path(@group)
    else
      @header_title = 'Transaction'
    end
  end

  def new
    @group = Group.find_by_id(params[:group_id])
    @groups = Group.where(author: current_user)
    @budget_transaction = BudgetTransaction.new
    @header_title = 'New Transaction'
  end

  def create
    @group = params[:group_id]
    @groups = params[:group_ids]
    @budget_transaction = current_user.budget_transactions.build(budget_transaction_params)
    if @budget_transaction.save
      GroupTransaction.create(budget_transaction: @budget_transaction, group_id: @group)
      unless @groups.nil? || @groups.empty?
        @groups.each do |group_id|
          GroupTransaction.create(budget_transaction: @budget_transaction, group_id:)
        end
      end
      redirect_to group_path(@group)
      flash[:notice] = 'Transaction was successfully created.'
    else
      flash[:error] = @budget_transaction.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @budget_transaction = BudgetTransaction.find_by_id(params[:id])
    group_id = params[:group_id]
    if @budget_transaction.destroy
      redirect_to group_path(group_id), notice: 'Transaction deleted'
    else
      flash[:error] = @budget_transaction.errors.full_messages.to_sentence
    end
  end

  private

  def budget_transaction_params
    params.require(:budget_transaction).permit(:name, :amount)
  end
end
