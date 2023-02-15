
class Review < ApplicationRecord
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :review, presence: true, length: {minimum: 1, maximum: 1000}
  belongs_to :book
  belongs_to :user

end

