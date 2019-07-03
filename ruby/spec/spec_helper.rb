if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require 'simplecov'
require 'simplecov-console'
SimpleCov.start do
  filters.clear
  add_filter ['/vendor/', '/spec/', '/.rbenv/']
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console,
  ]
end

require 'graphql/client/aws'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.filter_run_excluding(integration: true) unless ENV['CI']

  config.expose_dsl_globally = true
end
