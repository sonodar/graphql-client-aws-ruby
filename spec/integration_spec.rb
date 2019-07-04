require 'spec_helper'

Query = GraphQL.parse <<-'GRAPHQL'
    query list {
      listMyCustomTypes {
        items {
          id
          title
          content
        }
      }
    }
GRAPHQL

describe GraphQL::Client::Aws, integration: true do
  let(:region) { 'ap-northeast-1' }
  let(:access_key_id) { ENV.fetch('AWS_ACCESS_KEY_ID') }
  let(:secret_access_key) { ENV.fetch('AWS_SECRET_ACCESS_KEY') }
  let(:signer_opts) {
    {
        region: region,
        access_key_id: access_key_id,
        secret_access_key: secret_access_key
    }
  }
  let(:uri) { 'https://fmcrcnckrndolhucaegjfdqt54.appsync-api.ap-northeast-1.amazonaws.com/graphql' }
  let(:instance) { described_class.new(uri,signer_opts) }

  describe 'execute' do
    subject do
      res = instance.execute(document: Query, operation_name: 'list')
      res['data']['listMyCustomTypes']['items'].first
    end
    it { is_expected.to match({ 'title' => 'テストタイトル', 'content' => 'テストです', 'id' => 'ddd2429d-2e94-45d7-9aed-1fe112b43efd' }) }
  end
end
