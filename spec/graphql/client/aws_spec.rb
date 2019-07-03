require 'spec_helper'

describe GraphQL::Client::Aws do
  let(:region) { 'ap-northeast-1' }
  let(:access_key_id) { ENV.fetch('AWS_ACCESS_KEY_ID') { 'access_key_id' } }
  let(:secret_access_key) { ENV.fetch('AWS_SECRET_ACCESS_KEY') { 'secret_access_key' } }
  let(:signer_opts) {
    {
        region: region,
        access_key_id: access_key_id,
        secret_access_key: secret_access_key
    }
  }
  let(:uri) { 'https://fmcrcnckrndolhucaegjfdqt54.appsync-api.ap-northeast-1.amazonaws.com/graphql' }
  let(:instance) { described_class.new(uri,signer_opts) }

  subject { described_class.new(uri,signer_opts) }

  describe 'class' do
    subject { instance }
    it { is_expected.to be_a_kind_of GraphQL::Client::HTTP }
  end

  describe 'uri attribute' do
    subject { instance.uri.to_s }
    it { is_expected.to eq uri }
  end

  describe 'connection' do
    subject { instance.connection }
    it { is_expected.to be_an_instance_of GraphQL::Client::SignedHTTP }

    describe 'signer' do
      subject { instance.connection.signer }
      it { is_expected.to be_an_instance_of Aws::Sigv4::Signer }
    end
  end
end
