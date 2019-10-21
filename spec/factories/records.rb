FactoryBot.define do
  factory :record do
    date { "Sun, 20 Oct 2019 00:00:00 JST +09:00" }
    content {"サンプル"}
    amount {100}
    category {"サンプル"}
    wallet {"サンプル"}
    created_at { Faker::Time.between_dates(from: Date.today - 1, to: Date.today)}
    book
    user
  end
end