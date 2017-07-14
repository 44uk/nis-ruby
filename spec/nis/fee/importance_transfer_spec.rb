require 'spec_helper'

describe Nis::Fee::ImportanceTransfer do
  let(:remote_account) { '' }
  let(:mode) { :activate }
  let(:network) { :testnet }
  let(:tx) do
    Nis::Transaction::ImportanceTransfer.new(
      remote_account,
      mode,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context 'activate' do
    it { is_expected.to eq 150_000 }
  end

  context 'deactivate' do
    let(:mode)  { :deactivate }
    it { is_expected.to eq 150_000 }
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context 'activate' do
      it { is_expected.to eq 6_000_000 }
    end

    context 'deactivate' do
      let(:mode)  { :deactivate }
      it { is_expected.to eq 6_000_000 }
    end
  end

end
