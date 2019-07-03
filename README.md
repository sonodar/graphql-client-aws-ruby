[![Build Status](https://travis-ci.org/sonodar/graphql-client-aws-ruby.svg?branch=master)](https://travis-ci.org/sonodar/graphql-client-aws-ruby)
[![Coverage Status](https://coveralls.io/repos/github/sonodar/graphql-client-aws-ruby/badge.svg?branch=master)](https://coveralls.io/github/sonodar/graphql-client-aws-ruby?branch=master)
[![Gem Version](https://badge.fury.io/rb/graphql-client-aws.svg)](https://badge.fury.io/rb/graphql-client-aws)

# graphql-client-aws

`graphql-client`([github/graphql-client](https://github.com/github/graphql-client)) を AWS AppSync に対応させるための gem です。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql-client-aws'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphql-client-aws

## Usage

### Configuration

[オリジナルのサンプル](https://github.com/github/graphql-client#configuration)を以下のように書き換えて使用します。

```diff
require "graphql/client"
- require "graphql/client/http"
+ require "graphql/client/aws"

# Star Wars API example wrapper
module SWAPI
  # Configure GraphQL endpoint using the basic HTTP network adapter.
- HTTP = GraphQL::Client::HTTP.new("https://example.com/graphql") do 
+ HTTP = GraphQL::Client::Aws.new("https://example.com/graphql", region: 'us-east-1') do
    def headers(context)
      # Optionally set any HTTP headers
      { "User-Agent": "My Client" }
    end
  end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
