require 'spec_helper'

describe Nis::Transaction::Multisig do
  let(:recipient) { 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB' }
  let(:network) { :testnet }
  let(:ttx) { Nis::Transaction::Transfer.new(recipient, 1_000_000, '', network: network) }
  let(:tx)  { described_class.new(ttx, 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033', network: network) }

  subject { tx }

  describe '#type' do
    it { expect(subject.type).to eq 0x1004 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to a_hash_including(
        type: 0x1004,
        fee: 150_000
      )
    end
  end

  context 'on mainnet' do
    let(:network) { :mainnet }

    describe '#to_hash' do
      it do
        expect(subject.to_hash).to a_hash_including(
          type: 0x1004,
          fee: 6_000_000
        )
      end
    end
  end
end
