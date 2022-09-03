FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@dummy.com" }
    password { 'password' }

    trait :team do
      sequence(:email) { |n| "team-#{n}@dummy.com" }
      type { 'Team' }
    end
  end
end
