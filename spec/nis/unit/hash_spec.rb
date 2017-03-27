require 'spec_helper'

describe Nis::Unit::Hash do
  let(:value){ '949583a20ebdfdcb58277eb42fef3e66e9e6bbfc47304d8741a82c68f7c53a22' }
  let(:hash){ described_class.new(value) }
  let(:other){ described_class.new(value) }

  subject { hash }

  describe '#valid?' do
    it { expect(subject.valid?).to eq true }
  end

  describe '#==' do
    it { expect(subject == other).to eq true }
  end

  describe '#to_s' do
    it { expect(subject.to_s).to eq value }
  end
end
