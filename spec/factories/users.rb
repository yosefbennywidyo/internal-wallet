FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{DateTime.now.to_i}@dummy.com" }
    password { 'password' }

    trait :team do
      sequence(:email) { |n| "team-#{DateTime.now.to_i}@dummy.com" }
      type { 'Team' }
    end
  end
end
