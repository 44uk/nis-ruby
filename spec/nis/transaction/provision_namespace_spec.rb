require 'spec_helper'

describe Nis::Transaction::ProvisionNamespace do
  let(:new_part) { 'sushi' }
  let(:parent)   { nil }
  let(:network)  { :testnet }
  let(:tx) { described_class.new(new_part, parent, network: network) }

  subject { tx }

  describe '#type' do
    it { expect(subject.type).to eq 0x2001 }
  end

  describe '#root?' do
    it { expect(subject.root?).to be true }
  end

  describe '#sub?' do
    it { expect(subject.sub?).to be false }
  end

  describe '#to_hash' do
    it { expect(subject.rental_fee).to eq 100 * 1_000_000 }
    it { expect(subject.rental_fee_sink).to eq 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35' }
    it do
      expect(subject.to_hash).to match a_hash_including(
        type: 0x2001,
        newPart: 'sushi',
        parent: nil,
        rentalFee: 100 * 1_000_000,
        rentalFeeSink: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35',
        fee: 100_000_000
      )
    end
  end

  context 'when provision sub namespace' do
    let(:new_part) { 'nigiri' }
    let(:parent)   { 'sushi' }

    describe '#root?' do
      it { expect(subject.root?).to be false }
    end

    describe '#sub?' do
      it { expect(subject.sub?).to be true }
    end

    describe '#to_hash' do
      it do
        expect(subject.to_hash).to match a_hash_including(
          type: 0x2001,
          newPart: 'nigiri',
          parent: 'sushi',
          rentalFee: 10 * 1_000_000,
          rentalFeeSink: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35',
          fee: 10_000_000
        )
      end
    end
  end

  context 'on mainnet' do
    let(:network) { :mainnet }

    describe '#to_hash' do
      it do
        expect(subject.to_hash).to match a_hash_including(
          type: 0x2001,
          newPart: 'sushi',
          parent: nil,
          rentalFee: 100 * 1_000_000,
          rentalFeeSink: 'NAMESPACEWH4MKFMBCVFERDPOOP4FK7MTBXDPZZA',
          fee: 100_000_000
        )
      end
    end

    context 'when provision sub namespace' do
      let(:new_part) { 'nigiri' }
      let(:parent)   { 'sushi' }

      describe '#to_hash' do
        it do
          expect(subject.to_hash).to match a_hash_including(
            type: 0x2001,
            newPart: 'nigiri',
            parent: 'sushi',
            rentalFee: 10 * 1_000_000,
            rentalFeeSink: 'NAMESPACEWH4MKFMBCVFERDPOOP4FK7MTBXDPZZA',
            fee: 10_000_000
          )
        end
      end
    end
  end
end
