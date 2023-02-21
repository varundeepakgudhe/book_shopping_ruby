FactoryBot.define do

  factory :user do
    username {Faker::Internet.username}
    email {Faker::Internet.safe_email}
    password {"pass_too_long_abcd_1234"}
    password_confirmation {"pass_too_long_abcd_1234"}
    name {Faker::Name.first_name}
  end
end