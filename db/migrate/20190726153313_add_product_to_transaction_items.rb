class AddProductToTransactionItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :transaction_items, :product, foreign_key: true
  end
end
