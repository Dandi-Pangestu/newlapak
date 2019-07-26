class CreateTransactionItems < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_items do |t|
      t.belongs_to :transaction, foreign_key: true
      t.integer :qty

      t.timestamps
    end
  end
end
