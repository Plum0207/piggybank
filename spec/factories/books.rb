FactoryBot.define do
  factory :book do
    title {"サンプル"}
    users {[FactoryBot.build(:user)]}
  end
end