class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true,length: {minimum: 1, maximum: 1000}
  validates :author, presence: true, length: {minimum: 1, maximum: 1000}
  validates :publisher, presence: true,length: {minimum: 1, maximum: 1000}
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :price, presence: true, numericality: {allow_float: true, greater_than_or_equal_to: 0}




  def average_rating
    if self.reviews.size > 0
      return self.reviews.average(:rating)
    end
    return 0
    end
end

