require 'spec_helper'

describe Nis::Struct::AccountImportanceViewModel do
  let(:attrs) do
    {
      address: 'TD2JJJVPKDZFXWK3N3ZJLN7A5TGNOTM3J5EVSTIG',
      score: 0.001222376902598832,
      ev: 0.004252356221747241,
      isSet: 1,
      height: 40_926
    }
  end
  let(:struct) { described_class.new(attrs) }

  subject { struct }

  describe '#set?' do
    it { expect(subject.set?).to be true }
  end

  describe '#is_set' do
    it { expect(subject.respond_to?(:is_set)).to be true }
  end

  describe '#is_set=' do
    it { expect(subject.respond_to?(:is_set=)).to be true }
  end
end
