require 'spec_helper'

describe Nis::Transaction::Transfer do
  let(:amount)  { 100_000_000 }
  let(:fee)     { nil }
  let(:message) { Nis::Struct::Message.new }
  let(:version) { Nis::Util::TESTNET_VERSION_1 }
  let(:struct) do
    described_class.new(
      version: version,
      amount:  amount,
      fee:     fee,
      message: message
    )
  end

  subject { struct }

  describe '#type' do
    it { expect(subject.type).to eq 0x0101 }
  end

  describe '#testnet?' do
    it { expect(subject.testnet?).to be true }
  end

  describe '#mainnet?' do
    it { expect(subject.mainnet?).to be false }
  end

  describe '#version' do
    it { expect(subject.version).to be 1 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to a_hash_including(
        type: 0x0101,
        fee: 1_000_000
      )
    end
  end

  context 'amount: 100XEM, message: empty' do
    describe '#fee' do
      it { expect(subject.fee).to eq 1_000_000 }
    end

    describe '#to_hash' do
      it { expect(subject.to_hash[:fee]).to eq 1_000_000 }
    end
  end

  context 'amount: 100XEM, message: "Hello"' do
    let(:message) { Nis::Struct::Message.new('Hello') }
    describe '#fee' do
      it { expect(subject.fee).to eq 2_000_000 }
    end
  end

  context 'amount: 100XEM, message: "VERY_LONG_LONG_MESSAGE"' do
    let(:message) { Nis::Struct::Message.new('A' * 512) }
    describe '#fee' do
      it { expect(subject.fee).to eq 18_000_000 }
    end
  end

  context 'amount: 100XEM, message: empty, fee: 6_000_000' do
    let(:fee) { 6_000_000 }
    describe '#fee' do
      it { expect(subject.fee).to eq 6_000_000 }
    end
  end
end
