class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def average_rating
    if self.reviews.size > 0
      return self.reviews.average(:rating)
    end
    return 0
    end
end

