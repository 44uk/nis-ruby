require 'spec_helper'

describe Nis::Transaction::MosaicDefinitionCreation do
  let(:mo_def) do
    mosaic_id = Nis::Struct::MosaicId.new(
      namespaceId: 'sushi',
      name: 'maguro'
    )

    properties = Nis::Struct::MosaicProperties.new(
      divisibility: 0,
      initialSupply: 10_000,
      supplyMutable: true,
      transferable: true
    )

    levy = Nis::Struct::MosaicLevy.new(
      type: 1,
      recipient: 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB',
      mosaicId: {
        namespaceId: 'nem',
        name: 'xem'
      },
      fee: 100
    )

    Nis::Struct::MosaicDefinition.new(
      creator: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
      id: mosaic_id,
      description: 'Japanese soul food SUSHI.',
      properties: properties,
      levy: levy
    )
  end
  let(:tx) { described_class.new(mo_def, network: network) }
  let(:network) { :testnet }

  subject { tx }

  describe '#type' do
    it { expect(subject.type).to eq 0x4001 }
  end

  describe '#creation_fee' do
    it { expect(subject.creation_fee).to eq 20_000_000 }
  end

  describe '#creation_fee_sink' do
    it { expect(subject.creation_fee_sink).to eq 'TBMOSAICOD4F54EE5CDMR23CCBGOAM2XSJBR5OLC' }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to match a_hash_including(
        type: 0x4001,
        fee: 10_000_000,
        creationFee: 20_000_000,
        creationFeeSink: 'TBMOSAICOD4F54EE5CDMR23CCBGOAM2XSJBR5OLC',
        mosaicDefinition: {
          creator: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
          description: 'Japanese soul food SUSHI.',
          id: { namespaceId: 'sushi', name: 'maguro' },
          properties: [
            { name: 'divisibility', value: '0' },
            { name: 'initialSupply', value: '10000' },
            { name: 'supplyMutable', value: 'true' },
            { name: 'transferable', value: 'true' }
          ],
          levy: {
            type: 1,
            recipient: 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB',
            mosaicId: { namespaceId: 'nem', name: 'xem' },
            fee: 100
          }
        }
      )
    end
  end

  context 'on mainnet' do
    let(:network) { :mainnet }

    describe '#creation_fee' do
      it { expect(subject.creation_fee).to eq 20_000_000 }
    end

    describe '#creation_fee_sink' do
      it { expect(subject.creation_fee_sink).to eq 'NBMOSAICOD4F54EE5CDMR23CCBGOAM2XSIUX6TRS' }
    end

    describe '#to_hash' do
      it do
        expect(subject.to_hash).to match a_hash_including(
          fee: 10_000_000,
          creationFee: 20_000_000,
          creationFeeSink: 'NBMOSAICOD4F54EE5CDMR23CCBGOAM2XSIUX6TRS'
        )
      end
    end
  end
end
