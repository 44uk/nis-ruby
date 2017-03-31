require 'spec_helper'

describe Nis::Struct::NemRequestResult do
  let(:ret){ {type: 1, code: 1, message: 'status'} }
  let(:result){ described_class.new(ret) }

  subject { result }

  describe '#to_hash' do
    it { expect(subject.to_hash).to eq ret }
  end

  describe '#validation?' do
    it { expect(subject.validation?).to be true  }
  end

  describe '#heartbeat?' do
    let(:ret){ {type: 2, code: 1, message: 'status'} }
    it { expect(subject.heartbeat?).to be true  }
  end

  describe '#status?' do
    let(:ret){ {type: 4, code: 1, message: 'status'} }
    it { expect(subject.status?).to be true  }
  end
end
