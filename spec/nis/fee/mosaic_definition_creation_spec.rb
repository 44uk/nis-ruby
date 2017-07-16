require 'spec_helper'

describe Nis::Fee::MosaicDefinitionCreation do
  let(:mosaic_definition) {}
  let(:network) { :testnet }
  let(:tx) do
    Nis::Transaction::MosaicDefinitionCreation.new(
      mosaic_definition,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  it { is_expected.to eq 10_000_000 }

  context 'on mainnet' do
    let(:network) { :mainnet }
    it { is_expected.to eq 500_000_000 }
  end
end
