# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless Rails.env == 'test'
  unless User.all.length == 10
    [*1..10].map { |number|
      User.create!(email: "user-#{number}@test.com", password: 'password', password_confirmation: 'password')
    }
  end

  users = User.all

  puts "User created: #{users.length}"

  unless Transactional.all.length == 10
    users.map { |user|
      Transactional.create(type: 'Credit', details: {source: 'topup', note: 'tes', to: user.wallet.address, amount: '1000'}, wallet_id: user.wallet.id)
      user.wallet.update(balance: 1000)
    }
  end


  puts "Transactional created: #{Transactional.all.length}"
end