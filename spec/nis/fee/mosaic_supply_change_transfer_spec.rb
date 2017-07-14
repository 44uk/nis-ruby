require 'spec_helper'

describe Nis::Fee::MosaicSupplyChangeTransfer do
  let(:mosaic_id) { Nis::Struct::MosaicId.new(namespaceId: 'sushi', name: 'magro') }
  let(:mode) { :increase }
  let(:delta) { 1_000 }
  let(:network) { :testnet }
  let(:tx) do
    Nis::Transaction::MosaicSupplyChange.new(
      mosaic_id,
      mode,
      delta,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context 'increase' do
    it { is_expected.to eq 150_000 }
  end

  context 'decrease' do
    let(:mode)  { :descrease }
    it { is_expected.to eq 150_000 }
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context 'activate' do
      it { is_expected.to eq 20_000_000 }
    end

    context 'decrease' do
      let(:mode)  { :descrease }
      it { is_expected.to eq 20_000_000 }
    end
  end
end
