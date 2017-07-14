require 'spec_helper'

describe Nis::Transaction::ImportanceTransfer do
  let(:remote_account) { 'cc6c9485d15b992501e57fe3799487e99de272f79c5442de94eeb998b45e0144' }
  let(:mode) { :activate }
  let(:network) { :testnet }
  let(:tx) { described_class.new(remote_account, mode, network: network) }

  subject { tx }

  describe '#type' do
    it { expect(subject.type).to eq 0x0801 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to match a_hash_including(
        type: 0x0801,
        fee: 150_000,
        remoteAccount: remote_account,
        mode: 1
      )
    end
  end
end
