# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name = 'graphql-client-aws'
  s.version = '1.1.0'
  s.summary = 'GraphQL Client Adapter for AWS AppSync IAM Authorization'
  s.description = 'A Ruby library for declaring, composing and executing GraphQL queries for AWS AppSync IAM Authorization'
  s.homepage = 'https://github.com/sonodar/graphql-client-aws-ruby'
  s.license = 'MIT'

  s.files = Dir['README.md', 'LICENSE', 'lib/**/*.rb']

  s.add_dependency 'aws-sigv4'
  s.add_dependency 'graphql-client'

  # https://github.com/liufengyun/hashdiff/issues/45
  # https://github.com/bblimke/webmock/issues/822
  s.add_development_dependency 'hashdiff', '>= 1.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov', '~> 0.16.1'
  s.add_development_dependency 'simplecov-console'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'

  s.required_ruby_version = '>= 2.5'

  s.email = 'ryoheisonoda@outlook.com'
  s.authors = 'sonodar'
end
