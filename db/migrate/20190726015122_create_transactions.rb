class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, foreign_key: true
      t.string :receipt_code
      t.integer :status

      t.timestamps
    end
  end
end
