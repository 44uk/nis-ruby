require 'spec_helper'

describe Nis::Transaction::ImportanceTransfer do
  let(:struct) do
    described_class.new
  end

  subject { struct }

  describe '#type' do
    it { expect(subject.type).to eq 0x0801 }
  end

  describe '#fee' do
    it { expect(subject.fee).to eq 6_000_000 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to a_hash_including(
        type: 0x0801,
        fee: 6_000_000
      )
    end
  end
end
