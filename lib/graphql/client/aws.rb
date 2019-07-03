require 'graphql/client/http'
require 'json'
require 'aws-sigv4'
require 'net/http'

module GraphQL
  class Client
    class Aws < GraphQL::Client::HTTP
      def initialize(uri, **opts, &block)
        appsync_opts = opts.merge(service: 'appsync')
        @signer = ::Aws::Sigv4::Signer.new(appsync_opts)
        if block_given?
          super(uri, &block)
        else
          super(uri)
        end
      end

      def connection
        SignedHTTP.new(uri.host, uri.port).tap do |client|
          client.signer = @signer
          client.uri = uri
          client.use_ssl = uri.scheme == "https"
        end
      end
    end

    class SignedHTTP < Net::HTTP
      attr_accessor :signer, :uri

      # @param [Net::HTTPRequest] req
      def request(req, *args)
        signature = signer.sign_request(http_method: req.method, url: uri, body: req.body)
        req['Host'] = signature.headers['Host']
        req['X-Amz-Date'] = signature.headers['x-amz-date']
        req['X-Amz-Security-Token'] = signature.headers['x-amz-security-token']
        req['X-Amz-Content-Sha256']= signature.headers['x-amz-content-sha256']
        req['Authorization'] = signature.headers['authorization']
        req['Content-Type'] = 'application/graphql'
        super
      end
    end
  end
end
