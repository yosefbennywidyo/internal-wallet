FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{rand(1..1000)}@dummy.com" }
    password { 'password' }

    trait :team do
      sequence(:email) { |n| "team-#{rand(1..1000)}@dummy.com" }
      type { 'Team' }
    end
  end
end
