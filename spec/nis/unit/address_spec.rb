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

  describe 'from_public_key' do
    subject { described_class.from_public_key(public_key, network) }

    context 'mainnet' do
      let(:private_key) { '575dbb3062267eff57c970a336ebbc8fbcfe12c5bd3ed7bc11eb0481d7704ced' }
      let(:public_key)  { 'c5f54ba980fcbb657dbaaa42700539b207873e134d2375efeab5f1ab52f87844' }
      let(:address) { Nis::Unit::Address.new('NDD2CT6LQLIYQ56KIXI3ENTM6EK3D44P5JFXJ4R4') }
      let(:network) { :mainnet }

      it { expect(subject).to eq address }
    end

    context 'testnet' do
      let(:private_key) { '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214' }
      let(:public_key)  { 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033' }
      let(:address) { Nis::Unit::Address.new('TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB') }
      let(:network) { :testnet }

      it { expect(subject).to eq address }
    end
  end
end
