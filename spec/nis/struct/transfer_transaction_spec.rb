require 'spec_helper'

describe Nis::Struct::TransferTransaction do
  let(:amount)  { 100_000_000 }
  let(:fee)     { nil }
  let(:message) { Nis::Struct::Message.new }
  let(:struct) do
    described_class.new(
      amount:  amount,
      fee:     fee,
      message: message,
      type: Nis::Struct::Transaction::TRANSFER
    )
  end

  subject { struct }

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
