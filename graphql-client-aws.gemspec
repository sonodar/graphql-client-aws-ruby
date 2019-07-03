# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name = 'graphql-client-aws'
  s.version = '1.0.0'
  s.summary = 'GraphQL Client for AWS AppSync'
  s.description = 'A Ruby library for declaring, composing and executing GraphQL queries for AWS AppSync'
  s.homepage = 'https://github.com/sonodar/graphql-client-aws-ruby'
  s.license = 'MIT'

  s.files = Dir['README.md', 'LICENSE', 'lib/**/*.rb']

  s.add_dependency 'aws-sigv4', '~> 1.1'
  s.add_dependency 'graphql-client', '~> 0.14'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-console'

  s.required_ruby_version = '>= 2.3.0'

  s.email = 'ryoheisonoda@outlook.com'
  s.authors = 'sonodar'
end
