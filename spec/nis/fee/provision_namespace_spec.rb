require 'spec_helper'

describe Nis::Fee::ProvisionNamespace do
  let(:newpart) { 'sushi' }
  let(:parent)  { nil }
  let(:network) { :testnet }
  let(:tx) do
    Nis::Transaction::ProvisionNamespace.new(
      newpart,
      parent,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context 'root' do
    it { is_expected.to eq 100_000_000 }
  end

  context 'sub' do
    let(:parent)  { 'sushi' }
    it { is_expected.to eq 10_000_000 }
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context 'root' do
      it { is_expected.to eq 100_000_000 }
    end

    context 'sub' do
      let(:parent)  { 'sushi' }
      it { is_expected.to eq 10_000_000 }
    end
  end

end
