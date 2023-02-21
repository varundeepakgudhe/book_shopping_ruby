FactoryBot.define do
  factory :review do
    rating {rand(1..5).floor()}
    review {"fake review"}
    user
    book
  end
end
