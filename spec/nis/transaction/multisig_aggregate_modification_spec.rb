require 'spec_helper'

describe Nis::Transaction::MultisigAggregateModification do
  let(:mods) do
    [
      Nis::Struct::MultisigCosignatoryModification.new(
        modificationType: :add,
        cosignatoryAccount: '____public_key____'
      ),
    ]
  end
  let(:min_cosigs) { 1 }
  let(:network)  { :testnet }
  let(:tx) { described_class.new(mods, min_cosigs, network: network) }

  subject { tx }

  describe '#type' do
    it { expect(subject.type).to eq 0x1001 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to match a_hash_including(
        type: 0x1001,
        fee: 500_000
      )
    end
  end

  context 'on mainnet' do
    let(:network) { :mainnet }

    describe '#to_hash' do
      it do
        expect(subject.to_hash).to match a_hash_including(
          type: 0x1001,
          fee: 500_000
        )
      end
    end
  end
end
