# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'pry'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end

def markets_and_vendors
  @market1 = Market.create!(name: 'The Best Market', street: 'P. Sharman, 42 Wallaby Way', city: 'Syndey',
                            county: 'Cumberland', state: 'New South Wales', zip: '2000', lat: '38.9169984', lon: '-77.0320505')
  @market2 = Market.create!(name: 'The Worst Market', street: 'P. Sharman, 43 Wallaby Way', city: 'Syndey',
                            county: 'Cumberland', state: 'New South Wales', zip: '2000', lat: '38.9169984', lon: '-77.0320505')
  @market3 = Market.create!(name: 'Just A Market', street: 'P. Sharman, 44 Wallaby Way', city: 'Syndey',
                            county: 'Cumberland', state: 'New South Wales', zip: '2000', lat: '38.9169984', lon: '-77.0320505')
  @market4 = Market.create!(name: 'Bomba Market', street: 'P. Sharman, 45 Wallaby Way', city: 'Syndey',
                            county: 'Cumberland', state: 'New South Wales', zip: '2000', lat: '38.9169984', lon: '-77.0320505')

  @vendor1 = Vendor.create!(name: 'Elm Street Vendor', description: 'Just a vendor, homie',
                            contact_name: 'Freddy Krueger', contact_phone: '(911) 911-0911', credit_accepted: true)
  @vendor2 = Vendor.create!(name: 'Sun City Vendor', description: 'Just a vendor, homie', contact_name: 'Sean Cowans',
                            contact_phone: '(915) 915-9150', credit_accepted: true)
  @vendor3 = Vendor.create!(name: "Doll's R Us", description: 'Just a vendor, homie', contact_name: 'Chuck E.',
                            contact_phone: '(404) 404-0404', credit_accepted: true)
  @vendor4 = Vendor.create(name: 'BOMBA', description: 'Big boom', contact_name: 'Vladdy Daddy',
                           contact_phone: '(404) 404-0404', credit_accepted: true)

  @market_vendor1 = MarketVendor.create!(vendor_id: @vendor1.id, market_id: @market1.id)
  @market_vendor2 = MarketVendor.create!(vendor_id: @vendor1.id, market_id: @market2.id)
  @market_vendor3 = MarketVendor.create!(vendor_id: @vendor1.id, market_id: @market3.id)
  @market_vendor4 = MarketVendor.create!(vendor_id: @vendor2.id, market_id: @market1.id)
  @market_vendor5 = MarketVendor.create!(vendor_id: @vendor2.id, market_id: @market2.id)
  @market_vendor6 = MarketVendor.create!(vendor_id: @vendor3.id, market_id: @market1.id)
end
