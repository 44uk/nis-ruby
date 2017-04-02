require 'spec_helper'

describe Nis::Unit::Status do
  let(:value) { 'ACTIVE' }
  let(:status) { described_class.new(value) }
  let(:other) { described_class.new(value) }

  subject { status }

  describe '#active?' do
    it { expect(subject.active?).to eq true }
  end

  describe '#remote?' do
    let(:value) { 'REMOTE' }
    it { expect(subject.remote?).to eq true }
  end

  describe '#locked??' do
    let(:value) { 'LOCKED' }
    it { expect(subject.locked?).to eq true }
  end

  describe '#==' do
    it { expect(subject == other).to eq true }
  end

  describe '#to_s' do
    it { expect(subject.to_s).to eq value }
  end
end
