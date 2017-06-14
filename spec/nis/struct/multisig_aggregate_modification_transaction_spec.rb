require 'spec_helper'

describe Nis::Struct::MultisigAggregateModificationTransaction do
  let(:struct) do
    described_class.new
  end

  subject { struct }

  describe '#type' do
    it { expect(subject.type).to eq 0x1001 }
  end

  describe '#fee' do
    it { expect(subject.fee).to eq 16_000_000 }
  end
end
