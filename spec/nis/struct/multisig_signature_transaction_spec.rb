require 'spec_helper'

describe Nis::Struct::MultisigSignatureTransaction do
  let(:struct) do
    described_class.new
  end

  subject { struct }

  describe '#type' do
    it { expect(subject.type).to eq 0x1002 }
  end
end
