class Transaction < ApplicationRecord
  belongs_to :user
  has_many :transaction_items
  after_create :generate_receipt_code
  before_create :set_pending

  private

  def generate_receipt_code
    self.receipt_code = 'TRX-' + self.id.to_s
    self.save!
  end

  def set_pending
    self.status = 0
  end
end
