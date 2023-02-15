class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy


  validates :name, :presence => true
  validates :author, :presence => true
  validates :publisher, :presence => true
  validates :price, :presence => true
  validates :stock, :presence => true

  def average_rating
    if self.reviews.size > 0
      return self.reviews.average(:rating)
    end
    return 0
    end
end

