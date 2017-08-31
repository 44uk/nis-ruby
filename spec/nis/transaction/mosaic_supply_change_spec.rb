require 'spec_helper'

describe Nis::Transaction::MosaicSupplyChange do
  let(:mosaic_id) do
    Nis::Struct::MosaicId.new(
      namespaceId: 'sushi',
      name: 'maguro'
    )
  end
  let(:type) { :increase }
  let(:delta) { 1_000 }
  let(:network) { :testnet }
  let(:tx) { described_class.new(mosaic_id, type, delta, network: network) }

  subject { tx }

  describe '#type' do
    it { expect(subject.type).to eq 0x4002 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to match a_hash_including(
        type: 0x4002,
        fee: 150_000,
        supplyType: 0x001,
        delta: 1_000,
        mosaicId: {
          namespaceId: 'sushi',
          name: 'maguro'
        }
      )
    end
  end

  context 'on mainnet' do
    let(:network) { :mainnet }

    describe '#to_hash' do
      it do
        expect(subject.to_hash).to match a_hash_including(
          type: 0x4002,
          fee: 150_000,
          supplyType: 0x001,
          delta: 1_000,
          mosaicId: {
            namespaceId: 'sushi',
            name: 'maguro'
          }
        )
      end
    end
  end
end
