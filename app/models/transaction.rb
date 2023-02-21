class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :order
  validates :transaction_no, presence: true
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :total_price, presence: true, numericality: {allow_float: true, greater_than_or_equal_to: 0}

  validates :creditcard, presence: true, format: { with: /\A\d{16}\z/, message: "Invalid credit card number [ must be 16 digits ]" }
  validates :phoneno, presence: true, format: { with: /\A[0-9]{10}\Z/, message: "Invalid phone number [ must be 10 digits ]" }
  validates :address, presence: true, length: {minimum: 1, maximum: 10000}
end
