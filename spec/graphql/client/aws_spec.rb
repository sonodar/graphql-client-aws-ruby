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

describe GraphQL::Client::Aws do
  let(:region) { 'ap-northeast-1' }
  let(:signer_opts) {
    {
        region: region,
        access_key_id: 'hoge',
        secret_access_key: 'secret_access_key'
    }
  }
  let(:uri) { 'https://hoge.appsync-api.ap-northeast-1.amazonaws.com/graphql' }
  let(:instance) { described_class.new(uri, signer_opts) }

  describe 'class' do
    subject { instance }
    it { is_expected.to be_a_kind_of GraphQL::Client::HTTP }
    it { is_expected.to be_an_instance_of GraphQL::Client::Aws }
  end

  describe 'uri attribute' do
    subject { instance.uri.to_s }
    it { is_expected.to eq uri }
  end

  describe 'execute', :vcr do
    context 'when authorized' do
      subject do
        res = instance.execute(document: Query, operation_name: 'list')
        res['data']['listMyCustomTypes']['items'].first
      end
      it { is_expected.to match({ 'title' => 'テストタイトル', 'content' => 'テストです', 'id' => '12345' }) }
    end

    context 'when not authorized' do
      subject do
        res = instance.execute(document: Query, operation_name: 'list')
        res['errors'].first
      end
      it { is_expected.to match({ 'message' => '403 Forbidden' }) }
    end
  end
end
