require 'spec_helper'

describe Nis::Unit::Balance do
  let(:value) { 123_456_789 }
  let(:balance) { described_class.new(value) }
  let(:other) { described_class.new(value) }
  let(:small) { described_class.new(1_000_000) }
  let(:large) { described_class.new(9_000_000) }
  let(:added) { described_class.new(10_000_000) }
  let(:subtracted) { described_class.new(8_000_000) }

  subject { balance }

  describe '#in_nem?' do
    it { expect(subject.in_nem).to eq 123.456789 }
  end

  describe '#==' do
    it { expect(subject == other).to eq true }
  end

  describe '#<' do
    it { expect(small < large).to eq true }
  end

  describe '#>' do
    it { expect(large > small).to eq true }
  end

  describe '#+' do
    it { expect(large + small).to eq added }
  end

  describe '#-' do
    it { expect(large - small).to eq subtracted }
  end

  describe '#to_s' do
    it { expect(subject.to_s).to eq '123456789' }
  end
end
