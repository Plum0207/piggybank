FactoryBot.define do
  factory :book do
    title {"サンプル"}
    users {[FactoryBot.build(:user)]}
    created_at { Faker::Time.between_dates(from: Date.today - 1, to: Date.today)}
  end
end