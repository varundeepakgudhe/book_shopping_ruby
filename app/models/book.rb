class Book < ApplicationRecord
  has_many :reviews
  has_many :transactions

  def average_rating
    if self.reviews.size > 0
      return self.reviews.average(:rating)
    end
    return 0
    end
end

