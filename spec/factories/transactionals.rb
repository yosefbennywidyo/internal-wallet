FactoryBot.define do
  factory :transactional do
    date { DateTime.now }
    type { nil }
    details { nil }
    wallet_id { nil }

    trait :debit_to_team do
      type { 'Debit' }
      details { {source: User.first.wallet.address, note: 'transfer', to: Team.first.wallet.address, amount: '10.75'} }
      wallet_id { User.first.wallet.id }
    end

    trait :debit_to_user do
      type { 'Debit' }
      details { {source: Team.first.wallet.address, note: 'transfer', to: User.first.wallet.address, amount: '10.75'} }
      wallet_id { Team.first.wallet.id }
    end

    trait :credit_to_user do
      type { 'Credit' }
      details { {source: 'topup', note: 'tes', to: User.first.wallet.address, amount: '1000'} }
      wallet_id { User.first.wallet.id }
    end

    trait :credit_to_team do
      type { 'Credit' }
      details { {source: 'topup', note: 'tes', to: Team.first.wallet.address, amount: '1000'} }
      wallet_id { Team.first.wallet.id }
    end
  end
end
