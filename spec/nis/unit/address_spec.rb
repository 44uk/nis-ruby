require 'spec_helper'

describe Nis::Unit::Address do
  let(:value) { 'NCKMNCU3STBWBR7E3XD2LR7WSIXF5IVJIDBHBZQT' }
  let(:address) { described_class.new(value) }
  let(:other) { described_class.new(value) }

  subject { address }

  describe '#mainnet?' do
    it { expect(subject.mainnet?).to eq true }

    context 'with Testnet address' do
      let(:value) { 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' }
      it { expect(subject.mainnet?).to eq false }
    end

    context 'with Invalid address' do
      let(:value) { 'fnvawg94nvql' }
      it { expect(subject.mainnet?).to eq false }
    end
  end

  describe '#testnet?' do
    it { expect(subject.testnet?).to eq false }

    context 'with Testnet address' do
      let(:value) { 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' }
      it { expect(subject.testnet?).to eq true }
    end

    context 'with Invalid address' do
      let(:value) { 'fnvawg94nvql' }
      it { expect(subject.testnet?).to eq false }
    end
  end

  describe '#to_s' do
    it { expect(subject.to_s).to eq value }
  end

  describe '#to_hexadecimal' do
    it { expect(subject.to_hexadecimal).to eq '4e434b4d4e4355335354425742523745335844324c523757534958463549564a49444248425a5154' }
  end

  describe '#==' do
    it { expect(subject == other).to eq true }
  end

  describe '#valid?' do
    it { expect(subject.valid?).to eq true }

    context 'with Testnet address' do
      let(:value) { 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS' }
      it { expect(subject.valid?).to eq true }
    end

    context 'with Invalid address' do
      let(:value) { 'fnvawg94nvql' }
      it { expect(subject.valid?).to eq false }
    end
  end
end
