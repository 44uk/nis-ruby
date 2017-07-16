require 'spec_helper'

describe Nis::Fee::MultisigAggregateModification do
  let(:modifications) do
    [
      Nis::Struct::MultisigCosignatoryModification.new(
        modificationType: :add,
        cosignatoryAccount: ''
      )
    ]
  end
  let(:min_cosigs) { 1 }
  let(:network) { :testnet }
  let(:tx) do
    Nis::Transaction::MultisigAggregateModification.new(
      modifications,
      min_cosigs,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context 'increase' do
    it { is_expected.to eq 500_000 }
  end

  context 'decrease' do
    let(:mode)  { :descrease }
    it { is_expected.to eq 500_000 }
  end

  context '0 cosignatory' do
    let(:min_cosigs)  { 0 }
    it { is_expected.to eq 500_000 }
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context 'activate' do
      it { is_expected.to eq 22_000_000 }
    end

    context 'decrease' do
      let(:mode)  { :descrease }
      it { is_expected.to eq 22_000_000 }
    end

    context '0 cosignatory' do
      let(:min_cosigs)  { 0 }
      it { is_expected.to eq 16_000_000 }
    end
  end
end
