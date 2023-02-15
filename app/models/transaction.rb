class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :transaction_no, presence: true
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :total_price, presence: true, numericality: {allow_float: true, greater_than_or_equal_to: 0}

end
