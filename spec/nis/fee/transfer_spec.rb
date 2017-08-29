require 'spec_helper'

describe Nis::Fee::Transfer do
  let(:recipient) { 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF' }
  let(:amount)  { 1_000_000 }
  let(:message) { '' }
  let(:network) { :testnet }
  let(:tx) do
    Nis::Transaction::Transfer.new(
      recipient,
      amount,
      message,
      mosaics: mosaics,
      network: network
    )
  end
  let(:mosaics) { [] }
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context '1xem, no message' do
    it { is_expected.to eq 50_000 }
  end

  context '1xem, with message' do
    let(:message) { 'Good luck!' }
    it { is_expected.to eq 100_000 }
  end

  context '19,999xem, no message' do
    let(:amount)  { 19_999_000_000 }
    it { is_expected.to eq 50_000 }
  end

  context '20,000xem, no message' do
    let(:amount)  { 20_000_000_000 }
    it { is_expected.to eq 100_000 }
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context '1xem, no message' do
      it { is_expected.to eq 50_000 }
    end

    context '1xem, with message' do
      let(:message) { 'Good luck!' }
      it { is_expected.to eq 100_000 }
    end

    context '19,999xem, no message' do
      it { is_expected.to eq 50_000 }
    end

    context '20,000xem, no message' do
      let(:amount)  { 20_000_000_000 }
      it { is_expected.to eq 100_000 }
    end
  end
end
