require 'spec_helper'

describe Nis::Struct::Message do
  let(:value) { 'Hello' }
  subject { described_class.new(value) }

  describe '#encrypted?' do
    it { expect(subject.encrypted?).to eq false }
  end

  describe '#plain?' do
    it { expect(subject.plain?).to eq true }
  end

  describe '#bytesize' do
    it { expect(subject.bytesize).to eq 10 }
  end

  describe '#valid?' do
    it { expect(subject.valid?).to eq true }
  end

  describe '#to_hash' do
    it { expect(subject.to_hash).to eq payload: '48656c6c6f', type: 1 }
  end

  describe '#to_s' do
    it { expect(subject.to_s).to eq value }
  end
end
