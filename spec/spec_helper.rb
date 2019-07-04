require 'simplecov'
require 'simplecov-console'
SimpleCov.start do
  filters.clear
  add_filter ['/vendor/', '/spec/', '/.rbenv/', '/.rvm/']
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console,
  ]
end

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path('cassettes', __dir__)
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.debug_logger = $stderr
  c.default_cassette_options = {
    record: ENV.fetch('VCR_RECODE_MODE') { :none }.to_sym
  }
  c.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end

require 'graphql'
require 'graphql/client'
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
