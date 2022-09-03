class DirtyDatabaseError < RuntimeError
  def initialize(meta)
    super "#{meta[:full_description]}\n\t#{meta[:location]}"
  end
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)

    # setup database with `seeds.rb` for essential data only
    load "#{Rails.root}/db/seeds.rb"
  end

  config.before(:all, :cleaner_for_context) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.before(:each) do |example|
    next if example.metadata[:cleaner_for_context]

    DatabaseCleaner.strategy =
      if example.metadata[:js]
        :truncation
      else
        example.metadata[:strategy] || :transaction
      end

    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    next if example.metadata[:cleaner_for_context]

    DatabaseCleaner.clean

    # raise DirtyDatabaseError.new(example.metadata) if Record.count > 0
  end
  config.around(:each) do |rspec|
    DatabaseCleaner.cleaning do
      rspec.run
    end
  end
end