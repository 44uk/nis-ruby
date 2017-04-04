require 'spec_helper'

describe Nis::Struct::NemRequestResult do
  let(:attrs) { {type: 1, code: 1, message: 'status'} }
  let(:struct) { described_class.new(attrs) }

  subject { struct }

  describe '#[]' do
    it { expect(subject[:type]).to eq attrs[:type] }
    it { expect(subject['type']).to eq attrs[:type] }
  end

  describe '#to_hash' do
    it { expect(subject.to_hash).to eq attrs }
  end

  describe '#validation?' do
    it { expect(subject.validation?).to be true }
  end

  describe '#heartbeat?' do
    let(:attrs){ {type: 2, code: 1, message: 'status'} }
    it { expect(subject.heartbeat?).to be true  }
  end

  describe '#status?' do
    let(:attrs){ {type: 4, code: 1, message: 'status'} }
    it { expect(subject.status?).to be true  }
  end
end
