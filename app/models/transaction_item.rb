class TransactionItem < ApplicationRecord
  belongs_to :transactionObject, class_name: 'Transaction', foreign_key: 'transaction_id'
end
