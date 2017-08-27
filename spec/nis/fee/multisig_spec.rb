require 'spec_helper'

describe Nis::Fee::Multisig do
  let(:recipient) { 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF' }
  let(:amount) { 1_000_000 }
  let(:message) { 'Good luck!' }
  let(:signer) { '' }
  let(:network) { :testnet }
  let(:tx) do
    Nis::Transaction::Transfer.new(
      recipient,
      amount,
      message,
      network: network
    )
  end
  let(:mtx) do
    Nis::Transaction::Multisig.new(
      tx,
      signer,
      network: network
    )
  end

  let(:fee) { described_class.new(mtx) }

  subject { fee.to_i }

  it { is_expected.to eq 150_000 }

  context 'on mainnet' do
    let(:network) { :maitnet }

    context '1xem, no message' do
      it { is_expected.to eq 150_000 }
    end
  end
end
