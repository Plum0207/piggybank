FactoryBot.define do
  factory :user do
    sequence(:nickname) {Faker::Name.name}
    sequence(:email) {Faker::Internet.email}
    password {"00000000"}
    password_confirmation {"00000000"}
  end
end