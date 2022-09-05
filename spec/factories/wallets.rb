FactoryBot.define do
  factory :wallet do
    address { SecureRandom.uuid }
    user { nil }
  end
end
