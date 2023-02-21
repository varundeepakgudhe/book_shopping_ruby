FactoryBot.define do
  factory :book do
    name {Faker::Book.title}
    author {Faker::Book.author}
    publisher {Faker::Book.publisher}
    price {rand(1..99)}
    stock {rand(1..100)}
  end
end
