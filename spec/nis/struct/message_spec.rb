require 'spec_helper'

describe Nis::Struct::Message do
  let(:value) { 'Hello' }
  subject { described_class.new(value) }

  describe '#plain?' do
    it { expect(subject.plain?).to eq true }
  end

  describe '#encrypted?' do
    it { expect(subject.encrypted?).to eq false }
  end

  describe '#payload' do
    it { expect(subject.payload).to eq '48656c6c6f' }
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

  context 'with message encryption' do
    let(:private_key) { '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214' }
    let(:public_key) { '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933' }
    subject do
      described_class.new(value,
        private_key: private_key,
        public_key: public_key
      )
    end

    before do
      subject.encrypt!
    end

    describe '#plain?' do
      it { expect(subject.plain?).to eq false }
    end

    describe '#encrypted?' do
      it { expect(subject.encrypted?).to eq true }
    end

    describe '#payload' do
      it { expect(subject.payload).to match(/\A[0-9a-f]{128}\z/) }
    end

    describe '#decrypt!' do
      before { subject.decrypt! }
      it { expect(subject.payload).to eq '48656c6c6f' }
      it { expect(subject.plain?).to eq true }
      it { expect(subject.encrypted?).to eq false }
    end
  end

  context 'with encrypted message' do
    let(:value) { 'b19b9aa43cc1e3adeb6493aab5e687156d8f240b4ece74547c57e2abff9c2eef319265daf7ea74a09b194c49624b225e2b3f738b550c4eacff73c8f0b2a15813' }
    let(:type) { :encrypted }
    let(:private_key) { '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214' }
    let(:public_key) { '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933' }
    subject do
      described_class.new(value, type: type,
        private_key: private_key,
        public_key: public_key
      )
    end

    before do
      subject.decrypt!
    end

    describe '#plain?' do
      it { expect(subject.plain?).to eq true }
    end

    describe '#encrypted?' do
      it { expect(subject.encrypted?).to eq false }
    end

    describe '#value' do
      it { expect(subject.value).to eq 'Hello' }
    end

    describe '#payload' do
      it { expect(subject.payload).to eq '48656c6c6f' }
    end
  end

  context '#encrypt! then #decrypt!' do
    let(:value) { 'Good luck!' }
    let(:type) { :plain }
    let(:sender_private_key) { '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214' }
    let(:sender_public_key) { 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033' }
    let(:recipient_private_key) { '1d13af2c31ee6fb0c3c7aaaea818d9b305dcadba130ba663fc42d9f25b24ded1' }
    let(:recipient_public_key) { '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933' }
    subject do
      described_class.new(value, type: type,
        private_key: sender_private_key,
        public_key: recipient_public_key
      )
    end

    before do
      subject.encrypt!
      subject.private_key = recipient_private_key
      subject.public_key = sender_public_key
      subject.decrypt!
    end

    describe '#plain?' do
      it { expect(subject.plain?).to eq true }
    end

    describe '#encrypted?' do
      it { expect(subject.encrypted?).to eq false }
    end

    describe '#value' do
      it { expect(subject.value).to eq 'Good luck!' }
    end

    describe '#payload' do
      it { expect(subject.payload).to eq '476f6f64206c75636b21' }
    end
  end
end
