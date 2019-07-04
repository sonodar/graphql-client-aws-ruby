require 'graphql/client/http'
require 'json'
require 'aws-sigv4'
require 'net/http'

module GraphQL
  class Client
    class Aws < GraphQL::Client::HTTP
      def initialize(uri, **opts, &block)
        if block_given?
          super(uri, &block)
        else
          super(uri)
        end
        appsync_signer_option = opts.merge(service: 'appsync')
        @signer = ::Aws::Sigv4::Signer.new(appsync_signer_option)
      end

      def execute(document:, operation_name: nil, variables: {}, context: {})
        request = Net::HTTP::Post.new(uri.request_uri)

        request['Accept'] = 'application/json'
        headers(context).each { |name, value| request[name] = value }

        request.body = build_body(document, operation_name, variables)

        request = sign!(request)

        response = connection.request(request)

        case response
        when Net::HTTPOK, Net::HTTPBadRequest
          JSON.parse(response.body)
        else
          { 'errors' => [{ 'message' => "#{response.code} #{response.message}" }] }
        end
      end

      def build_body(document, operation_name, variables)
        body = { 'query' => document.to_query_string }
        body['variables'] = variables if variables.any?
        body['operationName'] = operation_name if operation_name
        JSON.generate(body)
      end

      def sign!(request)
        signature = @signer.sign_request(http_method: request.method, url: uri, body: request.body)
        request['Host'] = signature.headers['Host']
        request['X-Amz-Date'] = signature.headers['x-amz-date']
        request['X-Amz-Security-Token'] = signature.headers['x-amz-security-token']
        request['X-Amz-Content-Sha256']= signature.headers['x-amz-content-sha256']
        request['Authorization'] = signature.headers['authorization']
        request['Content-Type'] = 'application/graphql'
        request
      end
    end
  end
end
