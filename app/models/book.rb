class Book < ApplicationRecord
  has_many :reviews
  has_many :transactions

  def average_rating
    if self.reviews.size > 0
      self.reviews.average(:rating)
    end
    0
  end

end

