class TransactionController < ApplicationController
  before_action :authenticate_request
  before_action :set_transaction, only: [:cancel]

  def store
    errors = []
    transaction_params[:items].each do |item|
      product = Product.find(item[:product_id])
      if product.stock < item[:qty].to_i
        errors << 'Qty ' + product.name + ' doesnt insufficient'
      end
    end

    if errors.any?
      api({ messages: errors }, 422)
    else
      ActiveRecord::Base.transaction do
        transaction = Transaction.new(user: @current_user)
        if transaction.save
          transaction.transaction_items.create!(transaction_params[:items])
          api(message: 'Success')
        else
          api(transaction.errors, 422)
        end
      end
    end
  end

  def cancel
    if @transaction.status != 0
      api({ message: 'Transaction must be pending' }, 422)
    else
      ActiveRecord::Base.transaction do
        TransactionItem.where(transaction_id: @transaction.id).destroy_all
        if @transaction.destroy
          api(message: 'Success')
        else
          api({ message: 'Something wrong occur when cancel transaction' }, 422)
        end
      end
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(items: [[:product_id, :qty]])
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
