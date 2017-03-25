require 'spec_helper'

describe Nis do
  let(:nis) { Nis.new }

  subject { nis }

  describe '#heartbeat' do
    it { expect(subject.heartbeat).to eq hash_stub_from_json 'heartbeat' }
  end

  describe '#status' do
    it { expect(subject.status).to eq hash_stub_from_json 'status' }
  end

  describe '#request' do
    context '/account/get' do
      it { expect(subject.request(:get, 'account/get',
        address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
      )).to eq hash_stub_from_json 'account_get' }
    end

    context '/account/get/from-public-key' do
      it { expect(subject.request(:get, 'account/get/from-public-key',
        publicKey: 'f9bd190dd0c364261f5c8a74870cc7f7374e631352293c62ecc437657e5de2cd'
      )).to eq hash_stub_from_json 'account_get' }
    end

    context '/account/unlock' do
      it { expect(subject.request(:post, '/account/unlock',
        privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
      )).to eq nil }
    end
  end
end
