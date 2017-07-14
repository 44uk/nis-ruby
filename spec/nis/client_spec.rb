require 'spec_helper'
require 'webmock_helper'

describe Nis::Client do
  let(:client) { described_class.new }

  subject { client }

  describe '#options' do
    it do
      expect(subject.options).to match a_hash_including(
        scheme: 'http',
        host: '127.0.0.1',
        port: 7890,
        timeout: 5,
        url: 'http://127.0.0.1:7890'
      )
    end
  end

  context 'when ENV["NIS_URL"] set' do
    before do
      ENV['NIS_URL'] = 'http://node.example.com:6789'
    end

    after do
      ENV['NIS_URL'] = nil
    end

    describe '#options' do
      it do
        expect(subject.options).to match a_hash_including(
          host: 'node.example.com',
          port: 6789,
          url: 'http://node.example.com:6789'
        )
      end
    end

    describe '#options' do
      let(:client) { described_class.new(host: 'localhost', port: 7890) }
      it do
        expect(subject.options).to match a_hash_including(
          host: 'localhost',
          url: 'http://localhost:7890'
        )
      end
    end
  end

  describe '#request!' do
    context '/account/get with invalid address' do
      it { expect {  match subject.request!(:get, '/account/get',
        address: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
      ) }.to raise_error(Nis::BadRequestError) }
    end
  end

  describe '#request' do
    context '/heartbeat' do
      it { expect(subject.request(:get, '/heartbeat'
      )).to eq hash_stub_from_json('heartbeat') }
    end

    context '/status' do
      it { expect(subject.request(:get, '/status'
      )).to eq hash_stub_from_json('status') }
    end

    context '/shutdown' do
      it { expect(subject.request(:get, '/shutdown'
      )).to eq nil }
    end

    context '/account/get' do
      it { expect(subject.request(:get, '/account/get',
        address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
      )).to eq hash_stub_from_json('account_get') }
    end

    context '/account/unlock' do
      it { expect(subject.request(:post, '/account/unlock',
        privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
      )).to eq nil }
    end
  end
end
