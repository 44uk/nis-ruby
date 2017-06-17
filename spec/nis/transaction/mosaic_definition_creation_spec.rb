require 'spec_helper'

describe Nis::Transaction::MosaicDefinitionCreation do
  let(:struct) do
    described_class.new
  end

  subject { struct }

  describe '#type' do
    it { expect(subject.type).to eq 0x4001 }
  end

  describe '#fee' do
    it { expect(subject.fee).to eq 20_000_000 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to a_hash_including(
        type: 0x4001,
        fee: 20_000_000
      )
    end
  end
end
