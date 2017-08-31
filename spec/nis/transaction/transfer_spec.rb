require 'spec_helper'

describe Nis::Transaction::Transfer do
  let(:recipient) { 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF' }
  let(:amount)  { 1_000_000 }
  let(:message) { '' }
  let(:network)  { :testnet }
  let(:tx) { described_class.new(recipient, amount, message, network: network) }

  subject { tx }

  describe '#type' do
    it { expect(subject.type).to eq 0x0101 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to match a_hash_including(
        type: 0x0101,
        recipient: recipient,
        amount: 1_000_000,
        message: { type: 1, payload: '' },
        fee: 50_000
      )
    end
  end

  context 'on mainnet' do
    let(:network) { :mainnet }

    it do
      expect(subject.to_hash).to match a_hash_including(
        fee: 50_000
      )
    end
  end
end
