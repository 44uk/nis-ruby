require 'spec_helper'
require 'webmock_helper'

describe Nis::Client do
  let(:connection) { Nis::Connection.new }
  let(:client) { described_class.new(connection) }

  subject { client }

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
        value: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
      )).to eq nil }
    end
  end
end
